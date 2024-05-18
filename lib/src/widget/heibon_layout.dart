import 'package:flutter/material.dart';

class HeibonLayout extends StatelessWidget {
  final Widget title;
  final Widget body;

  const HeibonLayout({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20), child: body),
    );
  }
}
