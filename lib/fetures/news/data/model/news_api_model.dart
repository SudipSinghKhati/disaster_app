import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/news_entity.dart';

part 'news_api_model.g.dart';

final newsApiModelProvider = Provider<NewsApiModel>((ref) {
  return const NewsApiModel.empty();
});

@JsonSerializable()
class NewsApiModel extends Equatable {
  final String id;
  final String title;
  final String location;
  final String description;
  final String? image;
  final String user;

  const NewsApiModel({
    required this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.user,
    this.image,
  });

  const NewsApiModel.empty()
      : id = '',
        title = '',
        location = '',
        description = '',
        image = '',
        user = '';

  // convert API object to Entity
  NewsEntity toEntity() => NewsEntity(
        newsId: id,
        title: title,
        location: location,
        description: description,
        image: image,
        user: user,
      );

  // convert Entity to API object
  NewsApiModel fromEntity(NewsEntity entity) => NewsApiModel(
        id: entity.newsId!,
        title: title,
        location: location,
        description: description,
        image: image,
        user: user,
      );

  // convert API list to Entity list
  List<NewsEntity> toEntityList(List<NewsApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        id,
        title,
        location,
        description,
        image,
      ];

  factory NewsApiModel.fromJson(Map<String, dynamic> json) =>
      _$NewsApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsApiModelToJson(this);
}
