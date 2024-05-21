import 'package:d_box/src/page/home/vault_page.dart';
import 'package:d_box/src/page/setup_page.dart';
import 'package:d_box/src/util/future_builder.dart';
import 'package:d_box/src/util/service_locator.dart';
import 'package:d_box/src/widget/heibon_layout.dart';
import 'package:d_box/src/widget/progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class GreetingPage extends StatefulHookWidget {
  static const route = '/';

  const GreetingPage({super.key});

  @override
  _GreetingPageState createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final s = ServiceLocator.instance;
    final masterPasswordController = useTextEditingController();

    final isMasterPassSet = useMemoized(() => s.vaultDao.isMasterPassSet);
    final isMasterPassSetSnapshot = useFuture(isMasterPassSet);

    return autoWaitBuilderRoutine((context, snapshot) {
      if (snapshot.data == false) {
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => Navigator.of(context).pushReplacementNamed(SetupPage.route));
        return const Scaffold();
      }
      return HeibonLayout(
        title: Text(l.unlockTitle),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            TextFormField(
              decoration: InputDecoration(
                icon: const Icon(Icons.key),
                labelText: l.masterPasswordLabel,
              ),
              obscureText: true,
              controller: masterPasswordController,
            ),
            const Spacer(),
            ProgressButton(
              child: Text(l.unlock),
              onPressed: (controller) async {
                controller.forward();
                final ok =
                    await s.vaultDao.tryUnlock(masterPasswordController.text);
                if (!context.mounted) {
                  return;
                }
                if (ok) {
                  Navigator.of(context).pushReplacementNamed(VaultPage.route);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l.failedWrongPassword)));
                  controller.reverse();
                }
              },
            ),
          ],
        ),
      );
    })(context, isMasterPassSetSnapshot);
  }
}
