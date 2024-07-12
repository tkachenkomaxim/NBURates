import 'package:flutter/material.dart';

abstract class SettingsRepositoryBase {
  Future<ThemeMode> getThemeMode();
  Future<void> setThemeMode(ThemeMode mode);
  Future<Locale> getLocale();
  Future<void> setLocale(Locale locale);
}