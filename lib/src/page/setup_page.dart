import 'package:d_box/src/page/home/vault_page.dart';
import 'package:d_box/src/util/service_locator.dart';
import 'package:d_box/src/widget/heibon_layout.dart';
import 'package:d_box/src/widget/progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SetupPage extends HookWidget {
  static const route = '/setup';

  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useRef(GlobalKey<FormState>());
    final l = AppLocalizations.of(context);
    final s = ServiceLocator.instance;
    final masterPasswordController = useTextEditingController();

    return HeibonLayout(
      title: Text(l.setupTitle),
      body: Form(
          key: formKey.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.key_outlined),
                  labelText: l.masterPasswordLabel,
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 12) {
                    return l.passwordTooShort;
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: masterPasswordController,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.repeat_outlined),
                  labelText: l.masterPasswordRepeatLabel,
                ),
                obscureText: true,
                validator: (value) {
                  if (value != masterPasswordController.text) {
                    return l.passwordNotMatch;
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const Spacer(),
              ProgressButton(
                onPressed: (controller) async {
                  if (formKey.value.currentState!.validate()) {
                    controller.forward();
                    final ok = await s.vaultDao
                        .tryUnlock(masterPasswordController.text);
                    if (!context.mounted) {
                      return;
                    }
                    if (ok) {
                      Navigator.of(context)
                          .pushReplacementNamed(VaultPage.route);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l.operationFailed),
                        ),
                      );
                    }
                  }
                },
                child: Text(l.createVault),
              ),
            ],
          )),
    );
  }
}
