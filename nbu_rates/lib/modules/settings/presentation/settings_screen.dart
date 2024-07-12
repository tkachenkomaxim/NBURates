import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/settings_cubit.dart';
import '../bloc/settings_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SettingsCubit _settingsCubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        _settingsCubit = BlocProvider.of<SettingsCubit>(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('settings_screen').tr(),
          ),
          body: ListView(
            children: [
              _buildDarkModeSetting(state),
              _buildLanguageSetting(state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDarkModeSetting(SettingsState state) {
    return ListTile(
      title: const Text('dark_mode').tr(),
      trailing: Switch(
        value: state.darkMode,
        onChanged: (value) {
          _settingsCubit.toggleDarkMode();
        },
      ),
    );
  }

  Widget _buildLanguageSetting(SettingsState state) {
    return ListTile(
      title: const Text('language').tr(),
      trailing: DropdownButton<Locale>(
        value: state.selectedLanguage,
        onChanged: (Locale? newValue) {
          if (newValue != null) {
            context.setLocale(newValue);
            _settingsCubit.changeLanguage(newValue);
          }
        },
        items: state.supportedLanguages.map((locale) {
          return DropdownMenuItem<Locale>(
            value: locale,
            child: Text(_getLanguageName(locale)),
          );
        }).toList(),
      ),
    );
  }

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'english'.tr();
      case 'uk':
        return 'ukrainian'.tr();
      default:
        return locale.toString();
    }
  }

  @override
  void dispose() {
    _settingsCubit.close();
    super.dispose();
  }
}