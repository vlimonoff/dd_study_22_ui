import 'package:dio/dio.dart';
import '../../data/clients/auth_client.dart';

String baseUrl = "http://192.168.0.12:5050/";

class ApiModule {
  static AuthClient? _authClient;
  static AuthClient auth() =>
      _authClient ??
      AuthClient(
        Dio(),
        baseUrl: baseUrl,
      );
}
