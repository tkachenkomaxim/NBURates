import 'package:flutter_test/flutter_test.dart';
import 'package:nbu_rates/shared/infrastructure/network/request_type.dart';
import 'mockdata/network_service_fake.dart';

void main() {
  late MockNetworkService mockNetworkService;

  setUp(() {
    mockNetworkService = MockNetworkService();
  });

  test('send should return response for GET request', () async {
    final response = await mockNetworkService.send(
      url: 'https://example.com/api/data',
      requestType: RequestType.get,
    );

    expect(response.statusCode, 200);
  });

  test('send should return response for POST request', () async {
    final response = await mockNetworkService.send(
      url: 'https://example.com/api/data',
      requestType: RequestType.post,
    );

    expect(response.statusCode, 201);
  });

  test('send should throw exception on unsupported request type', () async {
    expect(
          () async => await mockNetworkService.send(
        url: 'https://example.com/api/data',
        requestType: RequestType.put, // Unsupported request type
      ),
      throwsException,
    );
  });
}