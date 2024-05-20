import 'package:d_box/src/util/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_locale.g.dart';

@riverpod
class AppLocale extends _$AppLocale {
  @override
  Locale? build() {
    final settings = ServiceLocator.instance.settingsService.settings;
    if (settings.languageCode == null) {
      return null;
    }
    return Locale(settings.languageCode!, settings.regionCode);
  }

  void setLocale(Locale? locale) {
    final service = ServiceLocator.instance.settingsService;
    final settings = service.settings;
    settings.languageCode = locale?.languageCode;
    settings.regionCode = locale?.countryCode;
    service.persistSettings();
    ref.invalidateSelf();
  }
}
