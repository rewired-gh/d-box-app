import 'package:d_box/src/page/greeting_page.dart';
import 'package:d_box/src/page/setup_page.dart';
import 'package:d_box/src/page/vault_page.dart';
import 'package:d_box/src/util/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.instance.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'D-Box',
        theme: ThemeData(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routes: {
          '/setup': (_) => const SetupPage(),
          '/vault': (_) => const VaultPage()
        },
        home: const GreetingPage());
  }
}
