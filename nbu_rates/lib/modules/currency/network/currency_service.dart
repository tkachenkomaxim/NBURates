import '../../../shared/infrastructure/network/network_service_base.dart';
import '../../../shared/infrastructure/network/request_type.dart';
import '../models/currency.dart';

class CurrencyService {
  final NetworkServiceBase _networkService;
  static const _url = 'https://bank.gov.ua/NBU_Exchange/exchange_site';

  CurrencyService(this._networkService);

  Future<List<Currency>> fetchCurrencies(String startDate, String endDate) async {
    final response = await _networkService.send(
      url: _url,
      requestType: RequestType.get,
      parameters: {
        'start': startDate,
        'end': endDate,
        'valcode': '',
        'sort': 'exchangedate',
        'order': 'desc',
        'json': ''
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return data.map((json) => Currency.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load currencies');
    }
  }
}