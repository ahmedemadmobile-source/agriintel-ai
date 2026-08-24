import 'dart:async';

import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../core/l10n.dart';
import '../data/mock_data.dart';
import '../data/models.dart';
import '../widgets/common.dart';
import 'result_screen.dart';

class DiagnoseScreen extends StatefulWidget {
  const DiagnoseScreen({super.key});

  @override
  State<DiagnoseScreen> createState() => _DiagnoseScreenState();
}

class _DiagnoseScreenState extends State<DiagnoseScreen> {
  Crop _crop = MockData.crops.first;
  bool _hasPhoto = false;
  bool _analyzing = false;
  int _step = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _pickPhoto() {
    setState(() => _hasPhoto = true);
  }

  void _analyze() {
    setState(() {
      _analyzing = true;
      _step = 0;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 750), (Timer timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_step >= 2) {
        timer.cancel();
        setState(() {
          _analyzing = false;
          _hasPhoto = false;
        });
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => ResultScreen(
              crop: _crop,
              disease: MockData.diagnosisFor(_crop.id),
            ),
          ),
        );
      } else {
        setState(() => _step++);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('diag.title')),
        actions: const <Widget>[LanguageButton(), SizedBox(width: 14)],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 6, 18, 28),
        children: <Widget>[
          Text(
            context.tr('diag.crop'),
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: context.strongText,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: MockData.crops.length,
              separatorBuilder: (_, __) => const SizedBox(width: 9),
              itemBuilder: (BuildContext context, int index) {
                final Crop crop = MockData.crops[index];
                final bool selected = crop.id == _crop.id;
                return GestureDetector(
                  onTap: () => setState(() => _crop = crop),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.primary : context.cardBg,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: selected ? AppColors.primary : context.borderColor,
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          crop.icon,
                          size: 17,
                          color: selected ? Colors.white : crop.color,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          context.pick(crop.name),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.5,
                            color: selected ? Colors.white : context.strongText,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 22),
          _captureArea(context),
          const SizedBox(height: 16),
          if (_analyzing)
            _analyzingBox(context)
          else if (_hasPhoto)
            Column(
              children: <Widget>[
                PrimaryButton(
                  label: context.tr('diag.analyze'),
                  icon: Icons.auto_awesome,
                  onPressed: _analyze,
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => setState(() => _hasPhoto = false),
                  child: Text(context.tr('diag.retake')),
                ),
              ],
            )
          else
            Row(
              children: <Widget>[
                Expanded(
                  child: _sourceButton(
                    context,
                    icon: Icons.photo_camera,
                    label: context.tr('diag.camera'),
                    filled: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _sourceButton(
                    context,
                    icon: Icons.photo_library_outlined,
                    label: context.tr('diag.gallery'),
                    filled: false,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 22),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(Icons.tips_and_updates_outlined,
                        size: 18, color: AppColors.sun),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        context.tr('diag.tips'),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: context.strongText,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _tip(context, context.tr('diag.tip1')),
                _tip(context, context.tr('diag.tip2')),
                _tip(context, context.tr('diag.tip3')),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              Icon(Icons.info_outline, size: 15, color: context.subtleText),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  context.tr('diag.demoNote'),
                  style: TextStyle(fontSize: 11.5, color: context.subtleText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _captureArea(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        decoration: BoxDecoration(
          color: context.cardBg,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: _hasPhoto ? AppColors.primary : context.borderColor,
            width: _hasPhoto ? 1.6 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: _hasPhoto
            ? Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  const LeafArt(),
                  if (_analyzing)
                    Container(color: Colors.black.withOpacity(0.25)),
                  Positioned(
                    top: 12,
                    left: 12,
                    right: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Pill(
                          label: context.pick(_crop.name),
                          color: AppColors.primaryDeep,
                          filled: true,
                          icon: _crop.icon,
                        ),
                        Pill(
                          label: 'IMG_2041.jpg',
                          color: Colors.black.withOpacity(0.45),
                          filled: true,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.center_focus_weak,
                        size: 30, color: AppColors.primary),
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      context.tr('diag.capture'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: context.subtleText,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _analyzingBox(BuildContext context) {
    final List<String> steps = <String>[
      context.tr('diag.s1'),
      context.tr('diag.s2'),
      context.tr('diag.s3'),
    ];

    return SectionCard(
      accent: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List<Widget>.generate(steps.length, (int index) {
          final bool done = index < _step;
          final bool active = index == _step;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 20,
                  height: 20,
                  child: done
                      ? const Icon(Icons.check_circle,
                          size: 19, color: AppColors.primary)
                      : active
                          ? const CircularProgressIndicator(
                              strokeWidth: 2.2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primary),
                            )
                          : Icon(Icons.circle_outlined,
                              size: 18, color: context.subtleText),
                ),
                const SizedBox(width: 12),
                Text(
                  steps[index],
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                    color: done || active ? context.strongText : context.subtleText,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _sourceButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool filled,
  }) {
    return SizedBox(
      height: 54,
      child: filled
          ? FilledButton.icon(
              onPressed: _pickPhoto,
              icon: Icon(icon, size: 20),
              label: Text(label),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle:
                    const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700),
              ),
            )
          : OutlinedButton.icon(
              onPressed: _pickPhoto,
              icon: Icon(icon, size: 20),
              label: Text(label),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: BorderSide(color: context.borderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle:
                    const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700),
              ),
            ),
    );
  }

  Widget _tip(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: context.subtleText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
