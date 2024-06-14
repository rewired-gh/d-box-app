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
    final isInCriticalAction = useState(false);

    return PopScope(
      canPop: !isInCriticalAction.value,
      child: HeibonLayout(
        title: Text(l.resetMasterPassword),
        body: Form(
          key: formKey.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Wrap(
                runSpacing: 10,
                children: [
                  Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.key_outlined),
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
                    ],
                  ),
                  Wrap(
                    spacing: 5.0,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Checkbox(
                        value: isItemsPreserved.value,
                        onChanged: (value) {
                          isItemsPreserved.value = value != false;
                        },
                      ),
                      Text(
                        l.preserveItemsLabel,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Text(
                    maxLines: 4,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 12,
                    ),
                    l.resetWarningP,
                  ),
                ],
              ),
              const Spacer(),
              ProgressButton(
                onPressed: (controller) async {
                  if (formKey.value.currentState!.validate()) {
                    controller.forward();
                    if (isItemsPreserved.value) {
                      isInCriticalAction.value = true;
                      await s.vaultDao
                          .changePassword(masterPasswordController.text);
                      isInCriticalAction.value = false;
                      if (!context.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l.operationDone),
                        ),
                      );
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
      ),
    );
  }
}
