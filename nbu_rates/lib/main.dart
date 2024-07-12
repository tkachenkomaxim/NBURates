import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:nbu_rates/shared/domain/repositories/settings_repository.dart';
import 'package:nbu_rates/shared/infrastructure/storages/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/application/app_configuration.dart';
import 'app/application/app_module.dart';
import 'app/presentation/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final sharedPreference = await SharedPreferences.getInstance();
  final storage = LocalStorage(sharedPreference);
  final locale = await SettingsRepository(storage).getLocale();

  runApp(
    EasyLocalization(
      supportedLocales: AppConfig.supportedLocales,
      path: AppConfig.translationPath,
      fallbackLocale: AppConfig.fallbackLocale,
      startLocale: locale,
      child: ModularApp(module: AppModule(storage),
          child: const AppWidget()),)
    ,
  );
}