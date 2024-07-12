
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../modules/currency/bloc/currency_cubit.dart';
import '../../modules/currency/network/currency_service.dart';
import '../../modules/currency/presentation/currency_screen.dart';
import '../../modules/home/bloc/home_cubit.dart';
import '../../modules/home/presentation/home_screen.dart';
import '../../modules/settings/bloc/settings_cubit.dart';
import '../../modules/settings/presentation/settings_screen.dart';
import '../../shared/domain/bloc/theme/theme_cubit.dart';
import '../../shared/domain/repositories/settings_repository.dart';
import '../../shared/infrastructure/network/network_service.dart';
import '../../shared/infrastructure/storages/local_storage.dart';

class AppModule extends Module {

  //AppModule Routes
  static const String home = "/";
  static const String currency = "/currency";
  static const String settings = "/settings";

  final LocalStorage _localStorage;

  AppModule(this._localStorage);

  @override
  List<Bind> get binds => [
    Bind.singleton((i) => _localStorage),
    Bind.singleton((i) => SettingsRepository(i<LocalStorage>())),
    Bind.singleton((i) => NetworkService()),
    Bind.singleton((i) => ThemeCubit(i<SettingsRepository>())),
  ];

  @override
  List<ModularRoute> get routes => [

    ChildRoute(
      home,
      child: (_, __) => BlocProvider(
        create: (context) => HomeCubit(),
        child: const HomeScreen(),
      ),
    ),

    ChildRoute(
     currency,
      child: (_, __) => BlocProvider(
        create: (context) => CurrencyCubit(CurrencyService(Modular.get<NetworkService>())),
        child: const CurrencyScreen(),
      ),
    ),

    ChildRoute(
      settings,
      child: (_, __) => BlocProvider(
        create: (context) => SettingsCubit(Modular.get<SettingsRepository>(),
            Modular.get<ThemeCubit>()),
        child: const SettingsScreen(),
      ),
    ),
  ];
}