import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/app_scope.dart';
import 'core/app_state.dart';
import 'core/app_theme.dart';
import 'screens/onboarding_screen.dart';

/// Root widget. Holds the single [AppState] instance and rebuilds the
/// [MaterialApp] whenever the language or the theme changes.
class AgriIntelApp extends StatefulWidget {
  const AgriIntelApp({super.key});

  @override
  State<AgriIntelApp> createState() => _AgriIntelAppState();
}

class _AgriIntelAppState extends State<AgriIntelApp> {
  final AppState _state = AppState();

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      notifier: _state,
      child: AnimatedBuilder(
        animation: _state,
        builder: (context, _) {
          return MaterialApp(
            title: 'AgriIntel AI',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: _state.themeMode,
            locale: _state.locale,
            supportedLocales: const <Locale>[Locale('ar'), Locale('en')],
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const OnboardingScreen(),
          );
        },
      ),
    );
  }
}
