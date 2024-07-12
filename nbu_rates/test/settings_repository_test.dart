
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nbu_rates/shared/domain/repositories/settings_repository.dart';
import 'package:nbu_rates/shared/domain/repositories/settings_repository_base.dart';
import 'mockdata/local_storage_fake.dart';

void main() {
  late SettingsRepositoryBase settingsRepository;
  late FakeLocalStorage fakeLocalStorage;

  setUp(() {
    fakeLocalStorage = FakeLocalStorage();
    settingsRepository = SettingsRepository(fakeLocalStorage);
  });

  group('SettingsRepository', () {
    test('should return light theme mode by default', () async {
      final themeMode = await settingsRepository.getThemeMode();
      expect(themeMode, ThemeMode.light);
    });

    test('should save and return dark theme mode', () async {
      await settingsRepository.setThemeMode(ThemeMode.dark);
      final themeMode = await settingsRepository.getThemeMode();
      expect(themeMode, ThemeMode.dark);
    });

    test('should save and return light theme mode', () async {
      await settingsRepository.setThemeMode(ThemeMode.light);
      final themeMode = await settingsRepository.getThemeMode();
      expect(themeMode, ThemeMode.light);
    });

    test('should return en_US locale by default', () async {
      final locale = await settingsRepository.getLocale();
      expect(locale, const Locale('en', 'US'));
    });

    test('should save and return a specific locale', () async {
      const locale = Locale('uk', 'UA');
      await settingsRepository.setLocale(locale);
      final savedLocale = await settingsRepository.getLocale();
      expect(savedLocale, locale);
    });
  });
}