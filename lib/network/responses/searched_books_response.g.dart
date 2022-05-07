// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searched_books_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchedBooksResponse _$SearchedBooksResponseFromJson(
        Map<String, dynamic> json) =>
    SearchedBooksResponse(
      (json['items'] as List<dynamic>?)
          ?.map((e) => SearchBookVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchedBooksResponseToJson(
        SearchedBooksResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
