import 'package:dd_study_22_ui/domain/models/post_content.dart';
import 'package:dd_study_22_ui/domain/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  String id;
  String? description;
  User author;
  DateTime created;
  int commentsCount;
  int likesCount;
  List<PostContent> contents;

  PostModel({
    required this.id,
    this.description,
    required this.author,
    required this.created,
    required this.contents,
    this.commentsCount = 0,
    this.likesCount = 0,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
