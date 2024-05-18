import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class VaultPage extends HookWidget {
  const VaultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Scaffold(
        appBar: AppBar(title: Text(l.vault)), body: Container() // TODO,
        );
  }
}
