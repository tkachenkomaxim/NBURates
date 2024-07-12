
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_cubit.dart';
import '../bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          // Use state from HomeCubit to build your UI
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTitle(context),
                  const SizedBox(height: 20),
                  _buildCurrencyButton(context),
                  const SizedBox(height: 20),
                  _buildSettingsButton(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'home_title'.tr(),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _buildCurrencyButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<HomeCubit>(context).goToCurrencyScreen();
      },
      child: const Text('go_to_currency_page').tr(),
    );
  }

  Widget _buildSettingsButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<HomeCubit>(context).goToSettingsScreen();
      },
      child: const Text('go_to_settings_page').tr(),
    );
  }
}
