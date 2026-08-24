import 'package:flutter/material.dart';

import '../core/app_scope.dart';
import '../core/app_state.dart';
import '../core/app_theme.dart';
import '../core/l10n.dart';
import 'assistant_screen.dart';
import 'dashboard_screen.dart';
import 'diagnose_screen.dart';
import 'insights_screen.dart';
import 'market_screen.dart';

class HomeShell extends StatelessWidget {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState app = AppScope.of(context);

    return Scaffold(
      body: IndexedStack(
        index: app.tabIndex,
        children: const <Widget>[
          DashboardScreen(),
          DiagnoseScreen(),
          AssistantScreen(),
          InsightsScreen(),
          MarketScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: context.cardBg,
          border: Border(top: BorderSide(color: context.borderColor)),
        ),
        child: NavigationBar(
          height: 70,
          selectedIndex: app.tabIndex,
          onDestinationSelected: app.setTab,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          indicatorColor: AppColors.primary.withOpacity(0.14),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: <NavigationDestination>[
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home, color: AppColors.primary),
              label: context.tr('nav.home'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.center_focus_weak_outlined),
              selectedIcon:
                  const Icon(Icons.center_focus_strong, color: AppColors.primary),
              label: context.tr('nav.diagnose'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.forum_outlined),
              selectedIcon: const Icon(Icons.forum, color: AppColors.primary),
              label: context.tr('nav.assistant'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.insights_outlined),
              selectedIcon: const Icon(Icons.insights, color: AppColors.primary),
              label: context.tr('nav.insights'),
            ),
            NavigationDestination(
              icon: const Icon(Icons.storefront_outlined),
              selectedIcon: const Icon(Icons.storefront, color: AppColors.primary),
              label: context.tr('nav.market'),
            ),
          ],
        ),
      ),
    );
  }
}
