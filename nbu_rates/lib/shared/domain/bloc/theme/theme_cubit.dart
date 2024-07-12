
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/settings_repository.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SettingsRepository settingsService;

  ThemeCubit(this.settingsService) : super(ThemeMode.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final themeMode = await settingsService.getThemeMode();
    emit(themeMode);
  }

  Future<void> toggleTheme() async {
    final newThemeMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await settingsService.setThemeMode(newThemeMode);
    emit(newThemeMode);
  }
}