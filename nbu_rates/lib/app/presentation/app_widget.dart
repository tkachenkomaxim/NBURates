
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../shared/domain/bloc/theme/theme_cubit.dart';
import '../application/app_colors.dart';
import '../application/app_configuration.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Modular.get<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router (

            title: AppConfig.title,
            theme: ThemeData(
                appBarTheme: AppBarTheme(color: themeMode == ThemeMode.dark ?
                                    AppColors.appBarPrimary : AppColors.appBarSecondary),
                primarySwatch: AppColors.primarySwatch,
                brightness: themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light,
                scaffoldBackgroundColor: themeMode == ThemeMode.dark ?
                AppColors.scaffoldBackgroundColorPrimary :
                AppColors.scaffoldBackgroundColorSecondary
            ),
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            routeInformationParser: Modular.routeInformationParser,
            routerDelegate: Modular.routerDelegate,
          );
        },
      ),
    );
  }
}