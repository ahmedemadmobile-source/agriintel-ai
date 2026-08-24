import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../core/l10n.dart';
import '../data/mock_data.dart';
import '../data/models.dart';
import '../widgets/charts.dart';
import '../widgets/common.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double weekTotal = MockData.irrigationWeek
        .fold<double>(0, (double sum, IrrigationDay d) => sum + d.millimetres);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('ins.title')),
        actions: const <Widget>[LanguageButton(), SizedBox(width: 14)],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 6, 18, 28),
        children: <Widget>[
          SectionCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        context.tr('ins.yield'),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: context.subtleText,
                        ),
                      ),
                    ),
                    Pill(
                      label: context.tr('ins.season'),
                      color: AppColors.primary,
                      icon: Icons.calendar_today,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      MockData.expectedYield.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 44,
                        height: 1,
                        fontWeight: FontWeight.w800,
                        color: context.strongText,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        context.tr('ins.unit'),
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: context.subtleText,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  context.trf('ins.range', <String, String>{
                    'a': MockData.yieldRangeLow.toStringAsFixed(1),
                    'b': MockData.yieldRangeHigh.toStringAsFixed(1),
                  }),
                  style: TextStyle(fontSize: 13, color: context.subtleText),
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: ConfidenceBar(
                        value: MockData.yieldConfidence,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${(MockData.yieldConfidence * 100).round()}% ${context.tr('res.confidence')}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SectionTitle(title: context.tr('ins.history')),
          SectionCard(
            padding: const EdgeInsets.fromLTRB(10, 18, 10, 14),
            child: Column(
              children: <Widget>[
                YieldBars(
                  points: MockData.yieldHistory,
                  unit: context.tr('ins.unit'),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _legendDot(AppColors.primary, context.tr('ins.history')),
                    const SizedBox(width: 18),
                    _legendDot(AppColors.sun, context.tr('ins.forecastTag')),
                  ],
                ),
              ],
            ),
          ),
          SectionTitle(title: context.tr('ins.irrigation')),
          SectionCard(
            accent: AppColors.sky,
            child: Row(
              children: <Widget>[
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.sky.withOpacity(0.13),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.water_drop,
                      color: AppColors.sky, size: 22),
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        context.tr('ins.next'),
                        style: TextStyle(fontSize: 12, color: context.subtleText),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        context.tr('ins.tonight'),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: context.strongText,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '38 ${context.tr('ins.mm')}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.sky,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SectionCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: MockData.irrigationWeek.map((IrrigationDay day) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 58,
                        child: Text(
                          context.pick(day.day),
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: day.skip ? context.subtleText : context.strongText,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          context.pick(day.note),
                          style: TextStyle(fontSize: 12.5, color: context.subtleText),
                        ),
                      ),
                      const SizedBox(width: 10),
                      day.skip
                          ? Pill(
                              label: context.tr('ins.skip'),
                              color: context.subtleText,
                            )
                          : Pill(
                              label:
                                  '${day.millimetres.toStringAsFixed(0)} ${context.tr('ins.mm')}',
                              color: AppColors.sky,
                            ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: SectionCard(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: <Widget>[
                      Text(
                        '${weekTotal.toStringAsFixed(0)} ${context.tr('ins.mm')}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: context.strongText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.tr('ins.weekWater'),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11.5, color: context.subtleText),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SectionCard(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        '−18%',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.tr('ins.savedWater'),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11.5, color: context.subtleText),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.satellite_alt_outlined, size: 15, color: context.subtleText),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  context.tr('ins.note'),
                  style: TextStyle(
                    fontSize: 11.5,
                    height: 1.6,
                    color: context.subtleText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 11.5, color: color)),
      ],
    );
  }
}
