import 'package:d_box/src/util/service_locator.dart';
import 'package:d_box/src/widget/heibon_layout.dart';
import 'package:d_box/src/widget/progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ResetPasswordPage extends HookWidget {
  static const route = '/settings/reset';

  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useRef(GlobalKey<FormState>());
    final l = AppLocalizations.of(context);
    final s = ServiceLocator.instance;
    final masterPasswordController = useTextEditingController();
    final isItemsPreserved = useState(true);

    return HeibonLayout(
      title: Text(l.resetMasterPassword),
      body: Form(
        key: formKey.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            TextFormField(
              decoration: InputDecoration(
                icon: const Icon(Icons.key),
                labelText: l.newMasterPasswordLabel,
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
                icon: const Icon(Icons.repeat),
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
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Wrap(
                spacing: 5.0,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Checkbox(
                    value: isItemsPreserved.value,
                    onChanged: (value) {
                      isItemsPreserved.value = value == true;
                    },
                  ),
                  Text(
                    l.preserveItemsLabel,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const Spacer(),
            ProgressButton(
              onPressed: (controller) async {
                if (formKey.value.currentState!.validate()) {
                  controller.forward();
                  if (isItemsPreserved.value) {
                    // TODO
                  } else {
                    await s.vaultDao.resetAll();
                    final ok = await s.vaultDao
                        .tryUnlock(masterPasswordController.text);
                    if (!context.mounted) {
                      return;
                    }
                    if (ok) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l.operationDone),
                        ),
                      );
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l.operationFailed),
                        ),
                      );
                    }
                  }
                  controller.reverse();
                }
              },
              child: Text(l.reset),
            ),
          ],
        ),
      ),
    );
  }
}
