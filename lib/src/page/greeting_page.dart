import 'package:d_box/src/util/service_locator.dart';
import 'package:flutter/material.dart';

class GreetingPage extends StatefulWidget {
  const GreetingPage({super.key});

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
        }
        if (snapshot.data == false) {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => Navigator.of(context).pushReplacementNamed('/setup'));
          return const Scaffold();
        }
        return Container(); // TODO
      },
    );
  }
}
