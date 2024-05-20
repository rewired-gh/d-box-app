import 'package:d_box/src/page/home/settings_page.dart';
import 'package:d_box/src/page/home/vault_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends HookWidget {
  static const route = '/vault';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    final pagePairs = useRef(<(Widget, Widget)>[
      (
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          label: l.home,
        ),
        const VaultPage(),
      ),
      (
        NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          label: l.settings,
        ),
        const SettingsPage(),
      ),
    ]);
    final currentPageIndex = useState(0);

    return Scaffold(
      body: pagePairs.value[currentPageIndex.value].$2,
      bottomNavigationBar: NavigationBar(
        destinations: pagePairs.value.map((p) => p.$1).toList(growable: false),
        selectedIndex: currentPageIndex.value,
        onDestinationSelected: (index) {
          currentPageIndex.value = index;
        },
      ),
    );
  }
}
