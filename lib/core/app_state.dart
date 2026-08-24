import 'package:flutter/material.dart';

import '../data/models.dart';

/// Single source of truth for everything the UI needs to remember:
/// language, theme, the selected bottom-nav tab, and saved diagnoses.
class AppState extends ChangeNotifier {
  Locale _locale = const Locale('ar');
  ThemeMode _themeMode = ThemeMode.light;
  int _tabIndex = 0;
  String? _pendingQuestion;
  final List<DiagnosisRecord> _history = <DiagnosisRecord>[];

  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;
  bool get isArabic => _locale.languageCode == 'ar';
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  int get tabIndex => _tabIndex;
  String? get pendingQuestion => _pendingQuestion;
  List<DiagnosisRecord> get history => List<DiagnosisRecord>.unmodifiable(_history);

  void toggleLanguage() {
    _locale = isArabic ? const Locale('en') : const Locale('ar');
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _themeMode = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setTab(int index) {
    if (index == _tabIndex) return;
    _tabIndex = index;
    notifyListeners();
  }

  void addDiagnosis(DiagnosisRecord record) {
    _history.insert(0, record);
    notifyListeners();
  }

  /// Sends a question to the assistant tab and jumps to it.
  void askAssistant(String question) {
    _pendingQuestion = question;
    _tabIndex = 2;
    notifyListeners();
  }

  /// Read once by the assistant screen; deliberately does not notify.
  void consumePendingQuestion() => _pendingQuestion = null;
}
