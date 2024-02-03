import 'package:json_annotation/json_annotation.dart';

import '../model/news_api_model.dart';

part 'get_my_news_dto.g.dart';

@JsonSerializable()
class GetMyNewsDTO {
  final List<NewsApiModel> data;

  GetMyNewsDTO({
    required this.data,
  });

factory GetMyNewsDTO.fromJson(Map<String, dynamic> json) =>
      GetMyNewsDTO(data: List<NewsApiModel>.from(json['data'].map((x) => NewsApiModel.fromJson(x))));

  Map<String, dynamic> toJson() => _$GetMyNewsDTOToJson(this);
}
