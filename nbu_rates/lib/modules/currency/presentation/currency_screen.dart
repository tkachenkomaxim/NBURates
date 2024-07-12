
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/application/app_colors.dart';
import '../../../shared/domain/errors/network_error.dart';
import '../../../shared/infrastructure/formatters/date_formatter.dart';
import '../bloc/currency_cubit.dart';
import '../bloc/currency_state.dart';
import '../models/currency.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({Key? key}) : super(key: key);

  @override
  _CurrencyScreenState createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  late CurrencyCubit _currencyCubit;

  @override
  void initState() {
    super.initState();
    _currencyCubit = BlocProvider.of<CurrencyCubit>(context);
  }

  Future<void> _selectDate(BuildContext context, DateTime initialDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _currencyCubit.fetchCurrencies(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('currency_screen').tr(),
      ),
      body: Column(
        children: [
          _buildDateSelector(context),
          Expanded(
            child: BlocBuilder<CurrencyCubit, CurrencyState>(
              builder: (context, state) {
                if (state is CurrencyLoading) {
                  return _buildSkeletonLoader();
                } else if (state is CurrencyLoaded) {
                  return _buildCurrencyList(state.currencies);
                } else if (state is CurrencyError) {
                  return _buildError(state.error);
                } else {
                  return Container(); // Handle other states or initial state
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    return BlocBuilder<CurrencyCubit, CurrencyState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () => _selectDate(context, state.selectedDate),
            child: Row(
              children: [
                Text(
                  DateFormatter.shwoFormat(state.selectedDate),
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(width: 8.0),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCurrencyList(List<Currency> currencies) {
    return ListView.builder(
      itemCount: currencies.length,
      itemBuilder: (context, index) {
        final currency = currencies[index];
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                currency.cc,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                currency.enname,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                currency.rate.toString(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSkeletonLoader() {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildShimmerBox(width: 50, height: 20),
              const SizedBox(width: 20),
              _buildShimmerBox(width: 150, height: 20),
              const SizedBox(width: 20),
              _buildShimmerBox(width: 50, height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmerBox({required double width, required double height}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.5, end: 1.0),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Container(
            width: width,
            height: height,
            color: AppColors.shimmerColor,
          ),
        );
      },
      onEnd: () {
        // Restart the animation
        setState(() {});
      },
    );
  }

  Widget _buildError(NetworkError error) {
    String errorMessage;
    switch (error) {
      case NetworkError.noInternet:
        errorMessage = 'no_internet_error'.tr();
        break;
      case NetworkError.failedLoading:
        errorMessage = 'currency_fetch_error'.tr();
        break;
    }

    return BlocBuilder<CurrencyCubit, CurrencyState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  errorMessage,
                  style: TextStyle(fontSize: 18, color: AppColors.errorColor),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () =>
                      _currencyCubit.fetchCurrencies(
                          state.selectedDate),
                  child: const Text('retry').tr(),
                ),
              ],
            ),
          );
        }
    );
  }

  @override
  void dispose() {
    _currencyCubit.close();
    super.dispose();
  }
}