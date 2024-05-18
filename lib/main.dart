import 'package:d_box/src/page/setup_page.dart';
import 'package:d_box/src/util/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.instance.init();
  runApp(MyApp());
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'D-Box',
        theme: ThemeData(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routes: {'/setup': (_) => const SetupPage()},
        home: FutureBuilder(
          future: ServiceLocator.instance.vaultDao.isMasterPassSet,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              if (snapshot.data == false) {
                WidgetsBinding.instance.addPostFrameCallback((_) =>
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/setup', (_) => false));
                return const Scaffold();
              }
              return const MyHomePage(title: "dummy");
            }
          },
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text("dummy"),
      ),
    );
  }
}
