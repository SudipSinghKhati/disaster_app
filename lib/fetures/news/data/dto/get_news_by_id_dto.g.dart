// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_news_by_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNewsByIdDTO _$GetNewsByIdDTOFromJson(Map<String, dynamic> json) =>
    GetNewsByIdDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => NewsApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetNewsByIdDTOToJson(GetNewsByIdDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
