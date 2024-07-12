import 'package:dio/dio.dart';
import 'package:nbu_rates/shared/infrastructure/network/network_service_base.dart';
import 'package:nbu_rates/shared/infrastructure/network/request_type.dart';

class MockNetworkService implements NetworkServiceBase {
  @override
  Future<Response> send({
    required String url,
    required RequestType requestType,
    Map<String, dynamic>? parameters,
  }) async {

    try {
      Response response;

      switch (requestType) {
        case RequestType.get:
          response = Response(requestOptions: RequestOptions(path: url), statusCode: 200);
          break;
        case RequestType.post:
          response = Response(requestOptions: RequestOptions(path: url), statusCode: 201);
          break;
        default:
          throw UnsupportedError('Request type not supported');
      }

      return response;
    } catch (e) {
      throw Exception('Failed to send request');
    }
  }
}