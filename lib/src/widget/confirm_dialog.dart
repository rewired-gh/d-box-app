import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    this.onConfirm,
  });

  final Widget title;
  final Widget content;
  final void Function()? onConfirm;

  @override
  Widget build(context) {
    final l = AppLocalizations.of(context);

    return AlertDialog(
      title: title,
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(l.cancel),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(l.confirm),
        ),
      ],
    );
  }
}
