import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:nbu_rates/shared/infrastructure/network/request_type.dart';
import '../../domain/errors/network_error.dart';
import 'network_service_base.dart';

class NetworkService implements NetworkServiceBase {
  final Dio _dio = Dio();
  final Connectivity _connectivity = Connectivity();

  @override
  Future<Response> send({
    required String url,
    required RequestType requestType,
    Map<String, dynamic>? parameters,
  }) async {
    // Check for connectivity
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw NetworkError.noInternet;
    }

    try {
      Response response;

      switch (requestType) {
        case RequestType.get:
          response = await _dio.get(url, queryParameters: parameters);
          break;
        case RequestType.post:
          response = await _dio.post(url, data: parameters);
          break;
        default:
          throw UnsupportedError('Request type not supported');
      }

      return response;
    } catch (e) {
      throw NetworkError.failedLoading;
    }
  }
}