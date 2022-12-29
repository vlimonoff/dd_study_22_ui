import 'package:dd_study_22_ui/domain/models/post_model.dart';
import 'package:dd_study_22_ui/domain/models/register_request.dart';
import 'package:dd_study_22_ui/domain/models/token_response.dart';
import 'package:dd_study_22_ui/domain/models/user.dart';
import 'dart:io';
import 'package:dd_study_22_ui/domain/models/attach_meta.dart';

abstract class ApiRepository {
  Future<TokenResponse?> getToken({
    required String login,
    required String password,
  });

  Future<TokenResponse?> refreshToken(String refreshToken);

  Future<User?> getUser();
  Future<List<PostModel>> getPosts(int skip, int take);

  Future<List<AttachMeta>> uploadTemp({required List<File> files});
  Future addAvatarToUser(AttachMeta model);

  Future registerUser(RegisterRequest model);
}
