// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_overview_list_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookOverviewListVO _$BookOverviewListVOFromJson(Map<String, dynamic> json) =>
    BookOverviewListVO(
      json['list_name'] as String?,
      json['list_name_encoded'] as String?,
      (json['books'] as List<dynamic>?)
          ?.map((e) => BookVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookOverviewListVOToJson(BookOverviewListVO instance) =>
    <String, dynamic>{
      'list_name': instance.listName,
      'list_name_encoded': instance.listNameEncoded,
      'books': instance.books,
    };
