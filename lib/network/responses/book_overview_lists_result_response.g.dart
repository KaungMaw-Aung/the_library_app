// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_overview_lists_result_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookOverviewListsResultResponse _$BookOverviewListsResultResponseFromJson(
        Map<String, dynamic> json) =>
    BookOverviewListsResultResponse(
      (json['lists'] as List<dynamic>?)
          ?.map((e) => BookOverviewListVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookOverviewListsResultResponseToJson(
        BookOverviewListsResultResponse instance) =>
    <String, dynamic>{
      'lists': instance.lists,
    };
