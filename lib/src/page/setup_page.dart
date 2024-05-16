import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SetupPage extends HookWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useRef(GlobalKey<FormState>());
    final l = AppLocalizations.of(context);

    final masterPassword = useState("");

    return Scaffold(
        appBar: AppBar(
          title: Text(l.setupTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Form(
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
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.value.currentState!.validate()) {
                          // TODO: Create vault
                        }
                      },
                      child: Text(l.createVault))
                ],
              )),
        ));
  }
}
