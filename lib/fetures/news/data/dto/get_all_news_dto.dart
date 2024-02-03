import 'package:json_annotation/json_annotation.dart';

import '../model/news_api_model.dart';

part 'get_all_news_dto.g.dart';

@JsonSerializable()
class GetAllNewsDTO {
  final List<NewsApiModel> data;

  GetAllNewsDTO({
    required this.data,
  });
  factory GetAllNewsDTO.fromJson(Map<String, dynamic> json) => GetAllNewsDTO(
      data: List<NewsApiModel>.from(
          json['data'].map((x) => NewsApiModel.fromJson(x))));

  Map<String, dynamic> toJson() => _$GetAllNewsDTOToJson(this);
}
