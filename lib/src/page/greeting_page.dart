import 'package:d_box/main.dart';
import 'package:d_box/src/util/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class GreetingPage extends StatefulHookWidget {
  const GreetingPage({Key? key}) : super(key: key);

  @override
  _GreetingPageState createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ServiceLocator.instance.vaultDao.isMasterPassSet,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          if (snapshot.data == false) {
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => Navigator.of(context).pushReplacementNamed('/setup'));
            return const Scaffold();
          }
          return const MyHomePage(title: "dummy");
        }
      },
    );
  }
}
