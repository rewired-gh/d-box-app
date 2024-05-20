import 'dart:convert';

import 'package:d_box/src/feature/vault/encrypted_item.dart';
import 'package:d_box/src/feature/vault/encrypted_item_meta.dart';
import 'package:d_box/src/feature/vault/item_meta_list.dart';
import 'package:d_box/src/feature/vault/vault_dao.dart';
import 'package:d_box/src/util/future_builder.dart';
import 'package:d_box/src/util/service_locator.dart';
import 'package:d_box/src/widget/heibon_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ItemInspectPageArgs {
  final EncryptedItemMeta meta;

  ItemInspectPageArgs(this.meta);
}

class ItemInspectPage extends HookConsumerWidget {
  static const route = '/vault/item';

  const ItemInspectPage({super.key});

  Future<(EncryptedItem, List<int>?)> _resolveItemDirectly(
      VaultDao vault, int id) async {
    final item = await vault.getItemById(id);
    final content = await item.getContent(vault.cachedMasterHash!);
    return (item, content);
  }

  @override
  Widget build(context, ref) {
    final l = AppLocalizations.of(context);
    final s = ServiceLocator.instance;
    final args =
        ModalRoute.of(context)!.settings.arguments as ItemInspectPageArgs;

    final formKey = useRef(GlobalKey<FormState>());
    final nameController = useTextEditingController(text: args.meta.name);
    final name = useState(nameController.text);
    final contentController = useTextEditingController();

    final resolvedPair =
        useMemoized(() => _resolveItemDirectly(s.vaultDao, args.meta.itemId));
    final resolvedPairSnapshot = useFuture(resolvedPair);

    final itemMetaListNotifier = ref.read(itemMetaListProvider.notifier);

    return HeibonLayout(
      title: Text(name.value),
      floatingActionButton: FloatingActionButton(
        onPressed: resolvedPairSnapshot.data != null
            ? () async {
                if (!formKey.value.currentState!.validate()) {
                  return;
                }
                final (item, content) = resolvedPairSnapshot.data!;
                await item.setContent(
                  s.vaultDao.cachedMasterHash!,
                  utf8.encode(contentController.text),
                );
                args.meta.name = nameController.text;
                await itemMetaListNotifier.setItem(args.meta, item);
                if (!context.mounted) {
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l.contentSaved),
                    showCloseIcon: true,
                  ),
                );
              }
            : null,
        tooltip: l.save,
        child: const Icon(Icons.save_outlined),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(l.confirmDelete),
                content: Text(l.actionCantUndoP),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(l.cancel),
                  ),
                  TextButton(
                    onPressed: () async {
                      await itemMetaListNotifier.removeItemById(args.meta.id);
                      if (!context.mounted) {
                        return;
                      }
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Text(l.confirm),
                  ),
                ],
              ),
            );
          },
        )
      ],
      body: Form(
        key: formKey.value,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: Wrap(
              runSpacing: 10,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.bookmark_outline),
                    labelText: l.itemNameLabel,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l.fieldCantEmpty;
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: nameController,
                  onChanged: (value) {
                    name.value = value;
                  },
                ),
                autoWaitBuilderRoutine<(EncryptedItem, List<int>?)?>(
                    (context, snapshot) {
                  final (item, content) = snapshot.data!;
                  if (content != null) {
                    contentController.text = utf8.decode(content);
                  }
                  return TextFormField(
                    decoration: InputDecoration(
                      icon: const Icon(Icons.article_outlined),
                      labelText: l.decryptedContentLabel,
                    ),
                    minLines: 1,
                    maxLines: 256,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l.fieldCantEmpty;
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: contentController,
                  );
                })(context, resolvedPairSnapshot),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
