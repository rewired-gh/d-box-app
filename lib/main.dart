import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:d_box/src/feature/settings/app_locale.dart';
import 'package:d_box/src/page/greeting_page.dart';
import 'package:d_box/src/page/home_page.dart';
import 'package:d_box/src/page/item_inspect_page.dart';
import 'package:d_box/src/page/setting/language_page.dart';
import 'package:d_box/src/page/setup_page.dart';
import 'package:d_box/src/util/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(context, ref) {
    final appLocale = ref.watch(appLocaleProvider);

    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.amber,
        brightness: Brightness.light,
      ),
      dark: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.amber,
        brightness: Brightness.dark,
      ),
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'D-Box',
        theme: theme,
        darkTheme: darkTheme,
        locale: appLocale,
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          LocaleNamesLocalizationsDelegate(),
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        routes: {
          GreetingPage.route: (_) => const GreetingPage(),
          SetupPage.route: (_) => const SetupPage(),
          HomePage.route: (_) => const HomePage(),
          ItemInspectPage.route: (_) => const ItemInspectPage(),
          LanguagePage.route: (_) => const LanguagePage(),
        },
      ),
    );
  }
}
