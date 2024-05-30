import 'dart:io';

import 'package:d_box/src/page/home/settings_page.dart';
import 'package:d_box/src/util/service_locator.dart';
import 'package:d_box/src/widget/heibon_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:path/path.dart' as p;
import 'package:share_plus/share_plus.dart';

class ManageDataPage extends HookWidget {
  static const route = '/settings/data';

  const ManageDataPage({super.key});

  @override
  Widget build(context) {
    final l = AppLocalizations.of(context);
    final s = ServiceLocator.instance;

    return HeibonLayout(
      isBleeding: true,
      title: Text(l.dataExportImport),
      body: ListView(
        children: [
          SettingTile(
            title: Text(l.exportToFile),
            icon: const Icon(Icons.output_rounded),
            onTap: () async {
              const zipFilename = 'vault_data.zip';
              final sourceDir = Directory(s.objectBoxDirectory!);
              final files = [
                File(p.join(sourceDir.path, ServiceLocator.objectBoxFilename))
              ];
              final zipFile = File(p.join(sourceDir.path, zipFilename));
              try {
                if (await zipFile.exists()) {
                  await zipFile.delete();
                }
                await ZipFile.createFromFiles(
                  sourceDir: sourceDir,
                  files: files,
                  zipFile: zipFile,
                );
              } catch (e) {
                if (!context.mounted) {
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l.operationFailed),
                  ),
                );
                return;
              }
              await Share.shareXFiles(
                [XFile(zipFile.path)],
                text: 'Vault data',
              );
              await zipFile.delete();
            },
          ),
          SettingTile(
            title: Text(l.importFromFile),
            icon: const Icon(Icons.input_rounded),
            onTap: () {
              // TODO
            },
          ),
        ],
      ),
    );
  }
}
