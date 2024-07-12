import 'package:flutter/material.dart';
import 'package:nbu_rates/shared/domain/repositories/settings_repository_base.dart';
import '../../infrastructure/storages/local_storage_base.dart';

class SettingsRepository implements SettingsRepositoryBase {
  static const String _themeKey = 'theme';
  static const String _languageKey = 'language';

  final LocalStorageBase _localStorage;

  SettingsRepository(this._localStorage);

  @override
  Future<ThemeMode> getThemeMode() async {

    final theme = _localStorage.read(_themeKey);
    if (theme == null) {
      return ThemeMode.light;
    } else {
      return theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
  }

  @override
  Future<void> setThemeMode(ThemeMode mode) async {
    await _localStorage.write(_themeKey, mode == ThemeMode.dark ? 'dark' : 'light');
  }

  @override
  Future<Locale> getLocale() async {
    final languageCode = _localStorage.read(_languageKey);
    if (languageCode == null) {
      return const Locale('en', 'US');
    } else {
      return Locale(languageCode.split('_')[0], languageCode.split('_')[1]);
    }
  }

  @override
  Future<void> setLocale(Locale locale) async {
    await _localStorage.write(_languageKey, '${locale.languageCode}_${locale.countryCode}');
  }
}