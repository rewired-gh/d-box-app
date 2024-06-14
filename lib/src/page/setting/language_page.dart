import 'package:d_box/src/feature/settings/app_locale.dart';
import 'package:d_box/src/util/service_locator.dart';
import 'package:d_box/src/widget/heibon_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_localized_locales/native_locale_names.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguagePage extends HookConsumerWidget {
  static const route = '/settings/language';

  const LanguagePage({super.key});

  @override
  Widget build(context, ref) {
    const locales = [null, ...AppLocalizations.supportedLocales];

    final l = AppLocalizations.of(context);
    final s = ServiceLocator.instance;

    final appLocaleNotifier = ref.read(appLocaleProvider.notifier);
    final appLocale = ref.watch(appLocaleProvider);

    final ValueNotifier<Locale?> selectedLocale = useState(appLocale);

    return HeibonLayout(
      isBleeding: true,
      title: Text(l.languageRegion),
      body: ListView.builder(
        itemCount: locales.length,
        itemBuilder: (context, i) {
          final locale = locales[i];
          final languageTag = locale?.toLanguageTag();
          final localeName = languageTag == null
              ? l.autoDetect
              : '${all_native_names[languageTag]} (${LocaleNames.of(context)!.nameOf(languageTag) ?? ""})';
          return RadioListTile(
            value: locale,
            groupValue: selectedLocale.value,
            onChanged: (value) {
              selectedLocale.value = value;
              appLocaleNotifier.setLocale(value);
            },
            title: Text(localeName),
          );
        },
      ),
    );
  }
}
