import 'package:d_box/src/page/greeting_page.dart';
import 'package:d_box/src/page/home_page.dart';
import 'package:d_box/src/page/item_inspect_page.dart';
import 'package:d_box/src/page/setup_page.dart';
import 'package:d_box/src/util/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.instance.init();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'D-Box',
        theme: ThemeData(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routes: {
          GreetingPage.route: (_) => const GreetingPage(),
          SetupPage.route: (_) => const SetupPage(),
          HomePage.route: (_) => const HomePage(),
          ItemInspectPage.route: (_) => const ItemInspectPage(),
        });
  }
}
