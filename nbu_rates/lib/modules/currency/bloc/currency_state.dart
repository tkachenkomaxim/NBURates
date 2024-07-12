
import 'package:equatable/equatable.dart';
import '../../../shared/domain/errors/network_error.dart';
import '../models/currency.dart';

abstract class CurrencyState extends Equatable {
  final DateTime selectedDate;

  const CurrencyState(this.selectedDate);

  @override
  List<Object?> get props => [selectedDate];
}

class CurrencyLoading extends CurrencyState {
  const CurrencyLoading(DateTime selectedDate) : super(selectedDate);
}

class CurrencyLoaded extends CurrencyState {
  final List<Currency> currencies;

  const CurrencyLoaded(DateTime selectedDate, this.currencies) : super(selectedDate);

  @override
  List<Object?> get props => [selectedDate, currencies];
}

class CurrencyError extends CurrencyState {
  final NetworkError error;

  const CurrencyError(DateTime selectedDate, this.error) : super(selectedDate);

  @override
  List<Object?> get props => [selectedDate, error];
}

