import 'package:dio/dio.dart';
import 'package:nbu_rates/shared/infrastructure/network/request_type.dart';

abstract class NetworkServiceBase {
  Future<Response> send({
    required String url,
    required RequestType requestType,
    Map<String, dynamic>? parameters,
  });
}