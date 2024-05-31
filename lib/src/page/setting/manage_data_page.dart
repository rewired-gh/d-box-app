import 'dart:io';

import 'package:cryptography/helpers.dart';
import 'package:d_box/src/page/home/settings_page.dart';
import 'package:d_box/src/util/service_locator.dart';
import 'package:d_box/src/widget/confirm_dialog.dart';
import 'package:d_box/src/widget/heibon_layout.dart';
import 'package:file_picker/file_picker.dart';
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
            icon: const Icon(Icons.upload_file_outlined),
            onTap: () async {
              const zipFilename = 'vault_data.zip';
              final zipFile =
                  File(p.join(s.appSupportDirectory!.path, zipFilename));
              try {
                if (await zipFile.exists()) {
                  await zipFile.delete();
                }
                await ZipFile.createFromDirectory(
                  sourceDir: Directory(s.objectBoxPath!),
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
              if (Platform.isMacOS) {
                // TODO: Support macOS in a better way
                await Share.shareXFiles([XFile(zipFile.path)]);
              } else {
                await FilePicker.platform.saveFile(
                  dialogTitle: l.exportToFile,
                  fileName: zipFilename,
                );
              }
            },
          ),
          SettingTile(
            title: Text(l.importFromFile),
            icon: const Icon(Icons.settings_backup_restore_rounded),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ConfirmDialog(
                    title: Text(l.confirmImport),
                    content: Text(l.overrideWarningP),
                    onConfirm: () async {
                      final result = await FilePicker.platform.pickFiles(
                        dialogTitle: l.chooseFileImport,
                        type: FileType.custom,
                        allowedExtensions: ['zip'],
                      );
                      if (result == null) {
                        return;
                      }
                      File zipFile = File(result.files.single.path!);
                      final destDir = s.appSupportDirectory!;
                      final backupPath = p.join(
                        destDir.path,
                        '${ServiceLocator.objectBoxDirectoryName}.bak${randomBytesAsHexString(8)}',
                      );
                      final prevPath = p.join(
                        destDir.path,
                        ServiceLocator.objectBoxDirectoryName,
                      );
                      Directory? backupDirectory;
                      try {
                        final prevDirectory = Directory(prevPath);
                        if (await prevDirectory.exists()) {
                          backupDirectory = await prevDirectory
                              .rename(p.join(destDir.path, backupPath));
                        }
                        await prevDirectory.create(recursive: true);
                        await ZipFile.extractToDirectory(
                          zipFile: zipFile,
                          destinationDir: prevDirectory,
                        );
                      } catch (e) {
                        if (backupDirectory != null) {
                          await backupDirectory.rename(prevPath);
                        }
                        if (!context.mounted) {
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l.operationFailed),
                          ),
                        );
                        return;
                      } finally {
                        if (backupDirectory != null) {
                          await backupDirectory.delete(recursive: true);
                        }
                      }
                      if (!context.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l.operationDone),
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
