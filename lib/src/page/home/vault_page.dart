import 'package:d_box/src/feature/vault/item_meta_list.dart';
import 'package:d_box/src/page/greeting_page.dart';
import 'package:d_box/src/page/item_inspect_page.dart';
import 'package:d_box/src/util/service_locator.dart';
import 'package:d_box/src/widget/heibon_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VaultPage extends HookConsumerWidget {
  static const route = '/vault';

  const VaultPage({super.key});

  @override
  Widget build(context, ref) {
    final l = AppLocalizations.of(context);
    final s = ServiceLocator.instance;
    final itemMetaList = ref.watch(itemMetaListProvider);
    final itemMetaListNotifier = ref.watch(itemMetaListProvider.notifier);
    final isBusy = useState(false);

    return HeibonLayout(
      isBleeding: true,
      title: Wrap(
        spacing: 20.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              l.vaultTitle,
              style: GoogleFonts.ibmPlexSans(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
            width: 20,
            child: isBusy.value
                ? const CircularProgressIndicator(
                    strokeWidth: 3,
                  )
                : null,
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.lock_reset_outlined),
          tooltip: l.lockVault,
          onPressed: () async {
            s.unloadVaultDao();
            Navigator.of(context).pushReplacementNamed(GreetingPage.route);
          },
        ),
        IconButton(
          icon: const Icon(Icons.add_outlined),
          tooltip: l.addItem,
          onPressed: () async {
            isBusy.value = true;
            final meta =
                await itemMetaListNotifier.createNewItem(l.newItemName);
            isBusy.value = false;
            if (!context.mounted) {
              return;
            }
            Navigator.of(context).pushNamed(
              ItemInspectPage.route,
              arguments: ItemInspectPageArgs(meta),
            );
          },
        ),
      ],
      body: switch (itemMetaList) {
        AsyncData(:final value) => ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, i) {
              final item = value[i];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 3.0,
                  horizontal: 16.0,
                ),
                leading: const Icon(Icons.lock_outline),
                title: Text(item.name),
                subtitle: Text(
                  l.createdDate(item.createdDate),
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12.0,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ItemInspectPage.route,
                    arguments: ItemInspectPageArgs(item),
                  );
                },
              );
            }),
        AsyncError(:final error) => Center(child: Text(error.toString())),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
