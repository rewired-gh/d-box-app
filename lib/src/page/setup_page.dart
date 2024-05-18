import 'package:d_box/src/util/debug.dart';
import 'package:d_box/src/util/service_locator.dart';
import 'package:d_box/src/widget/heibon_layout.dart';
import 'package:d_box/src/widget/progress_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SetupPage extends HookWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useRef(GlobalKey<FormState>());
    final l = AppLocalizations.of(context);
    final s = ServiceLocator.instance;
    final masterPassword = useState("");
    final isSettingUp = useState(false);

    return HeibonLayout(
      title: Text(l.setupTitle),
      body: Form(
          key: formKey.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.key),
                  labelText: l.setMasterPasswordLabel,
                ),
                obscureText: true,
                validator: (String? value) {
                  if (value == null || value.length < 10) {
                    return l.passwordTooShort;
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  masterPassword.value = value;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.repeat),
                  labelText: l.masterPasswordRepeatLabel,
                ),
                obscureText: true,
                validator: (String? value) {
                  if (value != masterPassword.value) {
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
                      final ok =
                          await s.vaultDao.tryUnlock(masterPassword.value);
                      if (!context.mounted) {
                        return;
                      }
                      if (ok) {
                        if (kDebugMode) {
                          await debug_delay();
                          if (!context.mounted) {
                            return;
                          }
                        }
                        Navigator.of(context).pushReplacementNamed('/vault');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(l.operationFailed),
                        ));
                      }
                    }
                  },
                  child: Text(l.createVault))
            ],
          )),
    );
  }
}
