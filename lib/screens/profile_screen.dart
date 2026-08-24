import 'package:flutter/material.dart';

import '../core/app_scope.dart';
import '../core/app_state.dart';
import '../core/app_theme.dart';
import '../core/l10n.dart';
import '../data/mock_data.dart';
import '../data/models.dart';
import '../widgets/common.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState app = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(context.tr('prof.title'))),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 6, 18, 30),
        children: <Widget>[
          SectionCard(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: <Widget>[
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.person,
                      size: 28, color: AppColors.primary),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        context.pick(MockData.farmerName),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: context.strongText,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        context.pick(MockData.farmName),
                        style:
                            TextStyle(fontSize: 12.5, color: context.subtleText),
                      ),
                    ],
                  ),
                ),
                Pill(
                  label: context.tr('prof.farmer'),
                  color: AppColors.primary,
                  icon: Icons.verified,
                ),
              ],
            ),
          ),
          SectionTitle(title: context.tr('prof.settings')),
          SectionCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.translate, color: AppColors.primary),
                  title: Text(
                    context.tr('prof.language'),
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: context.strongText,
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: app.toggleLanguage,
                    child: Text(
                      context.isArabic ? 'العربية' : 'English',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                Divider(color: context.borderColor, height: 1),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: app.isDarkMode,
                  activeColor: AppColors.primary,
                  onChanged: app.setDarkMode,
                  secondary: const Icon(Icons.dark_mode_outlined,
                      color: AppColors.primary),
                  title: Text(
                    context.tr('prof.theme'),
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: context.strongText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SectionTitle(title: context.tr('prof.history')),
          if (app.history.isEmpty)
            SectionCard(
              child: Text(
                context.tr('dash.empty'),
                style: TextStyle(fontSize: 13, color: context.subtleText),
              ),
            )
          else
            ...app.history.map((DiagnosisRecord record) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SectionCard(
                  child: Row(
                    children: <Widget>[
                      Icon(record.crop.icon, size: 20, color: record.crop.color),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          context.pick(record.disease.name),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: context.strongText,
                          ),
                        ),
                      ),
                      Pill(
                        label: '${(record.disease.confidence * 100).round()}%',
                        color: MockData.severityColor(record.disease.severity),
                      ),
                    ],
                  ),
                ),
              );
            }),
          SectionTitle(title: context.tr('prof.about')),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const LogoMark(size: 38),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        context.tr('app.name'),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: context.strongText,
                        ),
                      ),
                    ),
                    Text(
                      '${context.tr('prof.version')} 1.0.0',
                      style: TextStyle(fontSize: 11.5, color: context.subtleText),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  context.tr('prof.aboutBody'),
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.8,
                    color: context.subtleText,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  context.tr('prof.modules'),
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: context.strongText,
                  ),
                ),
                const SizedBox(height: 10),
                ...MockData.modules.map(
                  (Bilingual module) => Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Icon(Icons.check_circle_outline,
                            size: 16, color: AppColors.primary),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Text(
                            context.pick(module),
                            style: TextStyle(
                              fontSize: 12.5,
                              height: 1.55,
                              color: context.subtleText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  context.tr('prof.stack'),
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: context.strongText,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: MockData.stack
                      .map(
                        (Bilingual item) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 11, vertical: 7),
                          decoration: BoxDecoration(
                            color: context.isDark
                                ? Colors.white.withOpacity(0.05)
                                : const Color(0xFFF1F5F0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            context.pick(item),
                            style: TextStyle(
                              fontSize: 11.5,
                              color: context.subtleText,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.info_outline, size: 15, color: context.subtleText),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  context.tr('common.demo'),
                  style: TextStyle(fontSize: 11.5, color: context.subtleText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
