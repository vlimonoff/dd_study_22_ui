import 'package:dd_study_22_ui/domain/models/refresh_token_request.dart';
import 'package:dd_study_22_ui/domain/models/token_response.dart';
import 'package:dd_study_22_ui/domain/models/user.dart';

abstract class ApiRepository {
  Future<TokenResponse?> getToken({
    required String login,
    required String password,
  });

  Future<TokenResponse?> refreshToken(String refreshToken);

  Future<User?> getUser();
}
