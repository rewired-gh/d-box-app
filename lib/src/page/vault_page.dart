import 'package:d_box/src/feature/vault/item_meta_list.dart';
import 'package:d_box/src/page/item_inspect_page.dart';
import 'package:d_box/src/util/service_locator.dart';
import 'package:d_box/src/widget/heibon_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
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

    return HeibonLayout(
      isBleeding: true,
      title: Text(l.vaultTitle),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: l.addItem,
          onPressed: () async {
            await itemMetaListNotifier.createNewItem(l.newItemName);
          },
        ),
      ],
      body: switch (itemMetaList) {
        AsyncData(:final value) => ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, i) {
              final item = value[i];
              return ListTile(
                leading: const Icon(Icons.lock_outline),
                title: Text(item.name),
                subtitle: Text(l.createdDate(item.createdDate)),
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
