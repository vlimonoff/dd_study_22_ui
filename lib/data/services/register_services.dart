import 'dart:io';

import 'package:dd_study_22_ui/data/services/auth_service.dart';
import 'package:dd_study_22_ui/domain/models/register_request.dart';
import 'package:dd_study_22_ui/domain/repository/api_repository.dart';
import 'package:dd_study_22_ui/internal/dependencies/repository_module.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class RegisterService {
  final ApiRepository _api = RepositoryModule.apiRepository();

  Future registerUser(String? name, String? email, String? password,
      String? retryPassword, DateTime? birthDate) async {
    if (name != null &&
        email != null &&
        password != null &&
        retryPassword != null &&
        birthDate != null) {
      try {
        var df = DateFormat("yyyy-MM-dd");
        var tf = DateFormat("HH:mm:ss");

        final String bd =
            "${df.format(birthDate)}T${tf.format(birthDate)}+03:00";

        _api.registerUser(RegisterRequest(
          name: name,
          email: email,
          password: password,
          retryPassword: retryPassword,
          birthDate: bd,
        ));
      } on DioError catch (e) {
        if (e.error is SocketException) {
          throw NoNetworkException();
        } else if (<int>[500].contains(e.response?.statusCode)) {
          throw ServerException();
        }
      }
    }
  }
}
