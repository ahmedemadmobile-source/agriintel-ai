import 'package:flutter/material.dart';

import '../core/app_scope.dart';
import '../core/app_state.dart';
import '../core/app_theme.dart';
import '../core/l10n.dart';
import '../data/mock_data.dart';
import '../data/models.dart';
import '../widgets/charts.dart';
import '../widgets/common.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState app = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 74,
        titleSpacing: 20,
        title: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ProfileScreen(),
                ),
              ),
              child: const LogoMark(size: 42),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    context.trf('dash.greeting', <String, String>{
                      'name': context.pick(MockData.farmerName),
                    }),
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: context.strongText,
                    ),
                  ),
                  Text(
                    context.pick(MockData.farmName),
                    style: TextStyle(fontSize: 12, color: context.subtleText),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          const LanguageButton(),
          const SizedBox(width: 14),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 4, 18, 28),
        children: <Widget>[
          const _WeatherCard(),
          SectionTitle(title: context.tr('dash.actions')),
          _ActionCard(
            icon: Icons.water_drop,
            color: AppColors.sky,
            badge: context.tr('badge.today'),
            title: context.tr('act.irrigate.title'),
            body: context.tr('act.irrigate.body'),
            onTap: () => app.setTab(3),
          ),
          const SizedBox(height: 10),
          _ActionCard(
            icon: Icons.air,
            color: AppColors.warning,
            badge: context.tr('badge.now'),
            title: context.tr('act.spray.title'),
            body: context.tr('act.spray.body'),
            onTap: () => app.setTab(2),
          ),
          const SizedBox(height: 10),
          _ActionCard(
            icon: Icons.trending_up,
            color: AppColors.primary,
            badge: context.tr('badge.week'),
            title: context.tr('act.sell.title'),
            body: context.tr('act.sell.body'),
            onTap: () => app.setTab(4),
          ),
          SectionTitle(title: context.tr('dash.quick')),
          Row(
            children: <Widget>[
              Expanded(
                child: _QuickTile(
                  icon: Icons.center_focus_strong,
                  color: AppColors.primary,
                  label: context.tr('nav.diagnose'),
                  onTap: () => app.setTab(1),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickTile(
                  icon: Icons.forum,
                  color: AppColors.sky,
                  label: context.tr('nav.assistant'),
                  onTap: () => app.setTab(2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: _QuickTile(
                  icon: Icons.insights,
                  color: AppColors.sun,
                  label: context.tr('nav.insights'),
                  onTap: () => app.setTab(3),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickTile(
                  icon: Icons.storefront,
                  color: AppColors.leaf,
                  label: context.tr('nav.market'),
                  onTap: () => app.setTab(4),
                ),
              ),
            ],
          ),
          SectionTitle(title: context.tr('dash.recent')),
          if (app.history.isEmpty)
            SectionCard(
              onTap: () => app.setTab(1),
              child: Row(
                children: <Widget>[
                  Icon(Icons.photo_camera_back_outlined,
                      color: context.subtleText, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      context.tr('dash.empty'),
                      style: TextStyle(fontSize: 13.5, color: context.subtleText),
                    ),
                  ),
                ],
              ),
            )
          else
            ...app.history.take(3).map(
                  (DiagnosisRecord record) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _HistoryTile(record: record),
                  ),
                ),
          SectionTitle(
            title: context.tr('dash.market'),
            action: context.tr('dash.viewAll'),
            onAction: () => app.setTab(4),
          ),
          SectionCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Column(
              children: MockData.prices.take(3).map((PriceSeries price) {
                final bool up = price.changePct >= 0;
                final Color color = up ? AppColors.primary : AppColors.danger;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 70,
                        child: Text(
                          context.pick(price.name),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13.5,
                            color: context.strongText,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SparkLine(
                          values: price.lastWeek,
                          color: color,
                          height: 34,
                          showDot: false,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            price.today.toStringAsFixed(0),
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13.5,
                              color: context.strongText,
                            ),
                          ),
                          Text(
                            '${up ? '+' : ''}${price.changePct.toStringAsFixed(1)}%',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeatherCard extends StatelessWidget {
  const _WeatherCard();

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.wb_sunny, size: 18, color: AppColors.sun),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  context.tr('dash.weather'),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.5,
                    color: context.strongText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(
                child: StatTile(
                  icon: Icons.thermostat,
                  value: MockData.temperature,
                  caption: context.tr('dash.temp'),
                  color: AppColors.sun,
                ),
              ),
              Expanded(
                child: StatTile(
                  icon: Icons.water_drop_outlined,
                  value: MockData.humidity,
                  caption: context.tr('dash.humidity'),
                  color: AppColors.sky,
                ),
              ),
              Expanded(
                child: StatTile(
                  icon: Icons.air,
                  value: MockData.wind,
                  caption: context.tr('dash.wind'),
                  color: AppColors.primary,
                ),
              ),
              Expanded(
                child: StatTile(
                  icon: Icons.cloud_outlined,
                  value: MockData.rainChance,
                  caption: context.tr('dash.rain'),
                  color: AppColors.leaf,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.color,
    required this.badge,
    required this.title,
    required this.body,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final String badge;
  final String title;
  final String body;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      onTap: onTap,
      accent: color,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withOpacity(0.13),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 21),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.5,
                          color: context.strongText,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Pill(label: badge, color: color),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.55,
                    color: context.subtleText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickTile extends StatelessWidget {
  const _QuickTile({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: <Widget>[
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: color.withOpacity(0.13),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: color, size: 23),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13.5,
              color: context.strongText,
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.record});

  final DiagnosisRecord record;

  @override
  Widget build(BuildContext context) {
    final Color color = MockData.severityColor(record.disease.severity);
    final String time =
        '${record.at.hour.toString().padLeft(2, '0')}:${record.at.minute.toString().padLeft(2, '0')}';

    return SectionCard(
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 44,
            height: 44,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: const LeafArt(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  context.pick(record.disease.name),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: context.strongText,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${context.pick(record.crop.name)} · $time',
                  style: TextStyle(fontSize: 12, color: context.subtleText),
                ),
              ],
            ),
          ),
          Pill(
            label: '${(record.disease.confidence * 100).round()}%',
            color: color,
          ),
        ],
      ),
    );
  }
}
