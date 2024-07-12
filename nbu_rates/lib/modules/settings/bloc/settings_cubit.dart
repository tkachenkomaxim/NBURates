
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nbu_rates/modules/settings/bloc/settings_state.dart';
import '../../../shared/domain/bloc/theme/theme_cubit.dart';
import '../../../shared/domain/repositories/settings_repository_base.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepositoryBase _settingsService;
  final ThemeCubit _themeCubit;

  SettingsCubit(this._settingsService, this._themeCubit)
      : super(const SettingsState(
    darkMode: false,
    selectedLanguage: Locale('en', 'US'),
    supportedLanguages: [Locale('en', 'US'), Locale('uk', 'UA')],
  )) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final themeMode = await _settingsService.getThemeMode();
    final locale = await _settingsService.getLocale();
    emit(state.copyWith(
      darkMode: themeMode == ThemeMode.dark,
      selectedLanguage: locale,
    ));
  }

  void toggleDarkMode() {
    _themeCubit.toggleTheme();
    emit(state.copyWith(darkMode: !state.darkMode));
  }

  void changeLanguage(Locale newLanguage) {
    _settingsService.setLocale(newLanguage);

    emit(SettingsState(darkMode: state.darkMode,
                      selectedLanguage: newLanguage,
                      supportedLanguages: state.supportedLanguages));
  }
}