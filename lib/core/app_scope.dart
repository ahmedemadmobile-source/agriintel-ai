import 'package:flutter/material.dart';

import 'app_state.dart';

/// Makes the shared [AppState] available to every widget below it.
/// Widgets that call [AppScope.of] rebuild automatically when the state changes.
class AppScope extends InheritedNotifier<AppState> {
  const AppScope({
    super.key,
    required AppState notifier,
    required Widget child,
  }) : super(notifier: notifier, child: child);

  static AppState of(BuildContext context) {
    final AppScope? scope =
        context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope was not found above this widget.');
    return scope!.notifier!;
  }
}
