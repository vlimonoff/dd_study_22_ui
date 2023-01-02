import 'package:json_annotation/json_annotation.dart';

import 'package:dd_study_22_ui/domain/db_model.dart';

part 'post.g.dart';

@JsonSerializable()
class Post implements DbModel {
  @override
  final String id;
  final String description;
  final String? authorId;
  final DateTime created;
  final int commentsCount;
  final int likesCount;

  Post({
    required this.id,
    required this.description,
    this.authorId,
    required this.created,
    this.commentsCount = 0,
    this.likesCount = 0,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  factory Post.fromMap(Map<String, dynamic> map) => _$PostFromJson(map);

  @override
  Map<String, dynamic> toMap() => _$PostToJson(this);

  Post copyWith({
    String? id,
    String? description,
    String? authorId,
    DateTime? created,
    int? commentsCount,
    int? likesCount,
  }) {
    return Post(
      id: id ?? this.id,
      description: description ?? this.description,
      authorId: authorId ?? this.authorId,
      created: created ?? this.created,
      commentsCount: commentsCount ?? this.commentsCount,
      likesCount: likesCount ?? this.likesCount,
    );
  }
}
