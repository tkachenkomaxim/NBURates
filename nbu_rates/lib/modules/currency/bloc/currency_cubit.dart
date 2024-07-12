import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/domain/errors/network_error.dart';
import '../../../shared/infrastructure/formatters/date_formatter.dart';
import '../network/currency_service.dart';
import 'currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  final CurrencyService currencyService;

  CurrencyCubit(this.currencyService) : super(CurrencyLoading(DateTime.now())){
    fetchCurrencies(state.selectedDate);
  }

  Future<void> fetchCurrencies(DateTime selectedDate) async {
    String formattedDate = DateFormatter.formatDate(selectedDate);
    try {
      emit(CurrencyLoading(selectedDate));
      final currencies = await currencyService.fetchCurrencies(formattedDate, formattedDate);
      emit(CurrencyLoaded(selectedDate, currencies));
    } catch (e) {
      if (e is NetworkError) {
        emit(CurrencyError(selectedDate, e));
      } else {
        emit(CurrencyError(selectedDate, NetworkError.failedLoading));
      }
    }
  }
}
