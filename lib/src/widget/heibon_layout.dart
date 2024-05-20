import 'package:flutter/material.dart';

class HeibonLayout extends StatelessWidget {
  final Widget title;
  final Widget body;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final bool isBleeding;

  const HeibonLayout(
      {super.key,
      required this.title,
      required this.body,
      this.floatingActionButton,
      this.actions,
      this.isBleeding = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: actions
            ?.map((w) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: w,
                ))
            .toList(growable: false),
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: isBleeding
          ? body
          : Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20), child: body),
    );
  }
}
