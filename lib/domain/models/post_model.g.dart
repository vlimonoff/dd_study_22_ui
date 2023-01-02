// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: json['id'] as String,
      description: json['description'] as String?,
      author: User.fromJson(json['author'] as Map<String, dynamic>),
      created: DateTime.parse(json['created'] as String),
      contents: (json['contents'] as List<dynamic>)
          .map((e) => PostContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      commentsCount: json['commentsCount'] as int? ?? 0,
      likesCount: json['likesCount'] as int? ?? 0,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'author': instance.author,
      'created': instance.created.toIso8601String(),
      'commentsCount': instance.commentsCount,
      'likesCount': instance.likesCount,
      'contents': instance.contents,
    };
