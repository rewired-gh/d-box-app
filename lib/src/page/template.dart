import 'package:d_box/src/util/service_locator.dart';
import 'package:d_box/src/widget/heibon_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class __Page extends HookWidget {
  static const route = '/todo';

  const __Page({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final s = ServiceLocator.instance;

    return HeibonLayout(
      title: Text(l.vaultTitle),
      body: Container(),
    );
  }
}
