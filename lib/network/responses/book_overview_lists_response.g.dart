// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_overview_lists_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookOverviewListsResponse _$BookOverviewListsResponseFromJson(
        Map<String, dynamic> json) =>
    BookOverviewListsResponse(
      json['status'] as String?,
      json['results'] == null
          ? null
          : BookOverviewListsResultResponse.fromJson(
              json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookOverviewListsResponseToJson(
        BookOverviewListsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'results': instance.results,
    };
