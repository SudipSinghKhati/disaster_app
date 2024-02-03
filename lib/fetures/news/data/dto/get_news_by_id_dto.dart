import 'package:json_annotation/json_annotation.dart';

import '../model/news_api_model.dart';

part 'get_news_by_id_dto.g.dart';

@JsonSerializable()
class GetNewsByIdDTO {
  final List<NewsApiModel> data;

  GetNewsByIdDTO({
    required this.data,
  });


}
