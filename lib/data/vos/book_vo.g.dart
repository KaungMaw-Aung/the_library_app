// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookVO _$BookVOFromJson(Map<String, dynamic> json) => BookVO(
      json['book_image'] as String?,
      json['title'] as String?,
      json['author'] as String?,
      json['description'] as String?,
      json['price'] as String?,
      json['publisher'] as String?,
      json['createdAt'] as int?,
    );

Map<String, dynamic> _$BookVOToJson(BookVO instance) => <String, dynamic>{
      'book_image': instance.cover,
      'title': instance.title,
      'author': instance.author,
      'description': instance.description,
      'price': instance.price,
      'publisher': instance.publisher,
      'createdAt': instance.createdAt,
    };
