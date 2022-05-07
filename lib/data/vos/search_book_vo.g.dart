// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_book_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchBookVO _$SearchBookVOFromJson(Map<String, dynamic> json) => SearchBookVO(
      json['volumeInfo'] == null
          ? null
          : SearchBookVolumeInfoVO.fromJson(
              json['volumeInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchBookVOToJson(SearchBookVO instance) =>
    <String, dynamic>{
      'volumeInfo': instance.volumeInfo,
    };
