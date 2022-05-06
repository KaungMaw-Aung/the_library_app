// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'more_on_overview_list_result_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoreOnOverviewListResultResponse _$MoreOnOverviewListResultResponseFromJson(
        Map<String, dynamic> json) =>
    MoreOnOverviewListResultResponse(
      (json['book_details'] as List<dynamic>?)
          ?.map((e) => BookVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MoreOnOverviewListResultResponseToJson(
        MoreOnOverviewListResultResponse instance) =>
    <String, dynamic>{
      'book_details': instance.bookDetails,
    };
