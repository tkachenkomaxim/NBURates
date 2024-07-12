
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../app/application/app_module.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void goToCurrencyScreen() => Modular.to.pushNamed(AppModule.currency);

  void goToSettingsScreen() => Modular.to.pushNamed(AppModule.settings);
}