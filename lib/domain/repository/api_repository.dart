import 'package:dd_study_22_ui/domain/models/token_response.dart';

abstract class ApiRepository {
  Future<TokenResponse?> getToken(
      {required String login, required String password});
}
