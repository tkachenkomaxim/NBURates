import 'dart:ui';
import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final bool darkMode;
  final Locale selectedLanguage;
  final List<Locale> supportedLanguages;

  const SettingsState({
    required this.darkMode,
    required this.selectedLanguage,
    required this.supportedLanguages,
  });

  SettingsState copyWith({
    bool? darkMode,
    Locale? selectedLanguage,
    List<Locale>? supportedLanguages,
  }) {
    return SettingsState(
      darkMode: darkMode ?? this.darkMode,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      supportedLanguages: supportedLanguages ?? this.supportedLanguages,
    );
  }

  @override
  List<Object?> get props => [darkMode, selectedLanguage, supportedLanguages];
}