import 'package:flutter/material.dart';

import '../core/app_scope.dart';
import '../core/app_state.dart';
import '../core/app_theme.dart';
import '../core/l10n.dart';
import '../data/mock_data.dart';
import '../data/models.dart';
import '../widgets/common.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.crop, required this.disease});

  final Crop crop;
  final DiseaseInfo disease;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _saved = false;
  bool _expertRequested = false;

  String _severityLabel(BuildContext context) {
    switch (widget.disease.severity) {
      case Severity.low:
        return context.tr('sev.low');
      case Severity.medium:
        return context.tr('sev.medium');
      case Severity.high:
        return context.tr('sev.high');
    }
  }

  void _save() {
    final AppState app = AppScope.of(context);
    app.addDiagnosis(
      DiagnosisRecord(
        crop: widget.crop,
        disease: widget.disease,
        at: DateTime.now(),
      ),
    );
    setState(() => _saved = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.tr('res.saved'))),
    );
  }

  void _askAssistant() {
    final String question = context.isArabic
        ? 'إزاي أعالج ${context.pick(widget.disease.name)} في ${context.pick(widget.crop.name)}؟'
        : 'How do I treat ${context.pick(widget.disease.name)} in ${context.pick(widget.crop.name)}?';
    AppScope.of(context).askAssistant(question);
    Navigator.of(context).pop();
  }

  void _requestExpert() {
    setState(() => _expertRequested = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.tr('res.expertSent'))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DiseaseInfo disease = widget.disease;
    final Color severityColor = MockData.severityColor(disease.severity);
    final int confidencePct = (disease.confidence * 100).round();
    final Color confidenceColor =
        disease.isLowConfidence ? AppColors.warning : AppColors.primary;

    return Scaffold(
      appBar: AppBar(title: Text(context.tr('res.title'))),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 6, 18, 30),
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: SizedBox(
              height: 200,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  const LeafArt(),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 40, 16, 14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.transparent,
                            Colors.black.withOpacity(0.70),
                          ],
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Pill(
                            label: context.pick(widget.crop.name),
                            color: Colors.white.withOpacity(0.22),
                            filled: true,
                            icon: widget.crop.icon,
                          ),
                          const SizedBox(width: 8),
                          Pill(
                            label: _severityLabel(context),
                            color: severityColor,
                            filled: true,
                            icon: Icons.warning_amber_rounded,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            context.pick(disease.name),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: context.strongText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            disease.scientificName,
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: context.subtleText,
            ),
          ),
          const SizedBox(height: 18),
          SectionCard(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        context.tr('res.confidence'),
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: context.subtleText,
                        ),
                      ),
                    ),
                    Text(
                      '$confidencePct%',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: confidenceColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ConfidenceBar(
                  value: disease.confidence,
                  color: confidenceColor,
                ),
              ],
            ),
          ),
          if (disease.isLowConfidence) ...<Widget>[
            const SizedBox(height: 12),
            SectionCard(
              accent: AppColors.warning,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(Icons.help_outline,
                          size: 19, color: AppColors.warning),
                      const SizedBox(width: 8),
                      Text(
                        context.tr('res.lowTitle'),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: context.strongText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.tr('res.lowBody'),
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.6,
                      color: context.subtleText,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _expertRequested ? null : _requestExpert,
                      icon: Icon(
                        _expertRequested ? Icons.check : Icons.support_agent,
                        size: 19,
                      ),
                      label: Text(
                        _expertRequested
                            ? context.tr('res.expertSent')
                            : context.tr('res.expert'),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.warning,
                        side: const BorderSide(color: AppColors.warning),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SectionTitle(title: context.tr('res.about')),
          SectionCard(
            child: Text(
              context.pick(disease.summary),
              style: TextStyle(
                fontSize: 13.5,
                height: 1.8,
                color: context.subtleText,
              ),
            ),
          ),
          SectionTitle(title: context.tr('res.treatment')),
          SectionCard(
            child: Column(
              children: List<Widget>.generate(disease.treatment.length, (int i) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: i == disease.treatment.length - 1 ? 0 : 14,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          context.pick(disease.treatment[i]),
                          style: TextStyle(
                            fontSize: 13.5,
                            height: 1.65,
                            color: context.strongText,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          SectionTitle(title: context.tr('res.prevention')),
          SectionCard(
            child: Column(
              children: disease.prevention.map((Bilingual tip) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Icon(Icons.shield_outlined,
                          size: 17, color: AppColors.leaf),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          context.pick(tip),
                          style: TextStyle(
                            fontSize: 13.5,
                            height: 1.6,
                            color: context.subtleText,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 22),
          PrimaryButton(
            label: _saved ? context.tr('res.saved') : context.tr('res.save'),
            icon: _saved ? Icons.check : Icons.bookmark_border,
            onPressed: _saved ? null : _save,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _askAssistant,
              icon: const Icon(Icons.forum_outlined, size: 19),
              label: Text(context.tr('res.ask')),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(color: context.borderColor),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
