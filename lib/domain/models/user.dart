import 'package:json_annotation/json_annotation.dart';

import 'package:dd_study_22_ui/domain/db_model.dart';

part 'user.g.dart';

@JsonSerializable()
class User implements DbModel {
  @override
  final String id;
  final String name;
  final String email;
  final DateTime birthDate;
  final String? avatarLink;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.birthDate,
    this.avatarLink =
        "/api/Attach/GetUserAvatar/1feb23c5-e03e-4fa3-abde-2e7024bd8fb0",
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  Map<String, dynamic> toMap() => _$UserToJson(this);

  factory User.fromMap(Map<String, dynamic> map) => _$UserFromJson(map);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.birthDate == birthDate &&
        other.avatarLink == avatarLink;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        birthDate.hashCode ^
        avatarLink.hashCode;
  }
}
