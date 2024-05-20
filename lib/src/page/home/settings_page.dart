import 'package:d_box/src/page/setting/language_page.dart';
import 'package:d_box/src/widget/heibon_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SettingsPage extends HookWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return HeibonLayout(
      isBleeding: true,
      title: Text(l.settings),
      body: ListView(
        children: [
          SettingTile(
            icon: const Icon(Icons.language),
            title: Text(l.languageRegion),
            onTap: () {
              Navigator.of(context).pushNamed(LanguagePage.route);
            },
          ),
          SettingTile(
            icon: const Icon(Icons.color_lens_outlined),
            title: Text(l.colorTheme),
          ),
          SettingTile(
            icon: const Icon(Icons.password),
            title: Text(l.resetMasterPassword),
          ),
          SettingTile(
            icon: const Icon(Icons.swap_horiz),
            title: Text(l.dataExportImport),
          ),
          SettingTile(
            icon: const Icon(Icons.info_outline),
            title: Text(l.about),
            subTitle: Text(
              l.copyrightInfo('2024'),
              style: const TextStyle(
                fontFamily: "", // TODO
                fontWeight: FontWeight.w300,
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final Widget title;
  final Widget? subTitle;
  final Widget icon;
  final void Function()? onTap;

  const SettingTile({
    super.key,
    required this.title,
    required this.icon,
    this.subTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 3.0,
        horizontal: 16.0,
      ),
      leading: icon,
      title: title,
      subtitle: subTitle,
      onTap: onTap,
    );
  }
}
