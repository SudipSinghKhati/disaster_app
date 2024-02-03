// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_my_news_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMyNewsDTO _$GetMyNewsDTOFromJson(Map<String, dynamic> json) => GetMyNewsDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => NewsApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMyNewsDTOToJson(GetMyNewsDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
