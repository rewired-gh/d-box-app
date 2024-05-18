import 'package:d_box/src/widget/heibon_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class VaultPage extends StatelessWidget {
  const VaultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return HeibonLayout(title: Text(l.vaultTitle), body: Container());
  }
}
