import 'dart:async';

import 'package:flutter/material.dart';

import '../core/app_scope.dart';
import '../core/app_state.dart';
import '../core/app_theme.dart';
import '../core/l10n.dart';
import '../data/mock_data.dart';
import '../data/models.dart';
import '../widgets/common.dart';

class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scroll = ScrollController();
  bool _typing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppState app = AppScope.of(context);
    final String? pending = app.pendingQuestion;
    if (pending != null) {
      final String question = pending;
      app.consumePendingQuestion();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _send(question);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOut,
      );
    });
  }

  void _send(String raw) {
    final String text = raw.trim();
    if (text.isEmpty) return;

    final String lang = context.lang;
    _controller.clear();
    setState(() {
      _messages.add(ChatMessage(text: text, fromUser: true));
      _typing = true;
    });
    _scrollToEnd();

    Timer(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      final String? answer = MockData.answerFor(text, lang);
      setState(() {
        _typing = false;
        _messages.add(
          ChatMessage(
            text: answer ?? context.tr('asst.escalateBody'),
            fromUser: false,
            canEscalate: answer == null,
          ),
        );
      });
      _scrollToEnd();
    });
  }

  Future<void> _voiceInput() async {
    bool finished = false;

    final Future<void> sheet = showModalBottomSheet<void>(
      context: context,
      backgroundColor: context.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext _) => const _ListeningSheet(),
    );

    // Auto-close after a moment, unless the user already dismissed the sheet.
    Timer(const Duration(milliseconds: 1800), () {
      if (finished || !mounted) return;
      final NavigatorState navigator = Navigator.of(context);
      if (navigator.canPop()) navigator.pop();
    });

    await sheet;
    finished = true;
    if (!mounted) return;
    _controller.text = context.tr('asst.q1');
  }

  @override
  Widget build(BuildContext context) {
    final bool empty = _messages.isEmpty;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              context.tr('asst.title'),
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: context.strongText,
              ),
            ),
            Text(
              context.tr('asst.subtitle'),
              style: TextStyle(fontSize: 11.5, color: context.subtleText),
            ),
          ],
        ),
        actions: <Widget>[
          if (!empty)
            IconButton(
              tooltip: context.tr('asst.clear'),
              onPressed: () => setState(_messages.clear),
              icon: const Icon(Icons.delete_outline),
            ),
          const LanguageButton(),
          const SizedBox(width: 14),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              controller: _scroll,
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 16),
              children: <Widget>[
                _BotBubble(text: context.tr('asst.greeting')),
                ..._messages.map(
                  (ChatMessage message) => message.fromUser
                      ? _UserBubble(text: message.text)
                      : _BotBubble(
                          text: message.text,
                          canEscalate: message.canEscalate,
                        ),
                ),
                if (_typing) const _TypingBubble(),
                if (empty) ...<Widget>[
                  const SizedBox(height: 8),
                  Text(
                    context.tr('asst.suggest'),
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: context.subtleText,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <String>[
                      context.tr('asst.q1'),
                      context.tr('asst.q2'),
                      context.tr('asst.q3'),
                      context.tr('asst.q4'),
                    ].map((String question) {
                      return GestureDetector(
                        onTap: () => _send(question),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: context.cardBg,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: context.borderColor),
                          ),
                          child: Text(
                            question,
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
            decoration: BoxDecoration(
              color: context.cardBg,
              border: Border(top: BorderSide(color: context.borderColor)),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: _voiceInput,
                    icon: const Icon(Icons.mic_none, color: AppColors.primary),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primary.withOpacity(0.10),
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: _send,
                      style: TextStyle(fontSize: 14, color: context.strongText),
                      decoration: InputDecoration(
                        hintText: context.tr('asst.hint'),
                        hintStyle:
                            TextStyle(fontSize: 13.5, color: context.subtleText),
                        filled: true,
                        fillColor: context.isDark
                            ? Colors.white.withOpacity(0.05)
                            : const Color(0xFFF1F5F0),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 13),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(26),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => _send(_controller.text),
                    icon: const Icon(Icons.send_rounded, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ListeningSheet extends StatelessWidget {
  const _ListeningSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.mic, size: 34, color: AppColors.primary),
          ),
          const SizedBox(height: 18),
          Text(
            context.tr('asst.listening'),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: context.strongText,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            context.tr('asst.voiceNote'),
            style: TextStyle(fontSize: 12, color: context.subtleText),
          ),
          const SizedBox(height: 20),
          const LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            backgroundColor: Color(0x221B8A4B),
          ),
        ],
      ),
    );
  }
}

class _UserBubble extends StatelessWidget {
  const _UserBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(18),
            topEnd: Radius.circular(18),
            bottomStart: Radius.circular(18),
            bottomEnd: Radius.circular(4),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13.5,
            height: 1.6,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _BotBubble extends StatelessWidget {
  const _BotBubble({required this.text, this.canEscalate = false});

  final String text;
  final bool canEscalate;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.82,
        ),
        decoration: BoxDecoration(
          color: context.cardBg,
          border: Border.all(color: context.borderColor),
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(18),
            topEnd: Radius.circular(18),
            bottomStart: Radius.circular(4),
            bottomEnd: Radius.circular(18),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.smart_toy_outlined,
                    size: 15, color: AppColors.primary),
                const SizedBox(width: 6),
                Text(
                  context.tr('app.name'),
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.75,
                color: context.strongText,
              ),
            ),
            if (canEscalate) ...<Widget>[
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(context.tr('res.expertSent'))),
                  );
                },
                icon: const Icon(Icons.support_agent, size: 18),
                label: Text(context.tr('asst.escalate')),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.sky,
                  side: const BorderSide(color: AppColors.sky),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: context.cardBg,
          border: Border.all(color: context.borderColor),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              context.tr('asst.typing'),
              style: TextStyle(fontSize: 12.5, color: context.subtleText),
            ),
          ],
        ),
      ),
    );
  }
}
