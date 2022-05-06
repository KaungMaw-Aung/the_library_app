// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'more_on_overview_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoreOnOverviewListResponse _$MoreOnOverviewListResponseFromJson(
        Map<String, dynamic> json) =>
    MoreOnOverviewListResponse(
      json['status'] as String?,
      (json['results'] as List<dynamic>?)
          ?.map((e) => MoreOnOverviewListResultResponse.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MoreOnOverviewListResponseToJson(
        MoreOnOverviewListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'results': instance.results,
    };
