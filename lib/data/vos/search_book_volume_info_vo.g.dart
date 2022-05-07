// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_book_volume_info_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchBookVolumeInfoVO _$SearchBookVolumeInfoVOFromJson(
        Map<String, dynamic> json) =>
    SearchBookVolumeInfoVO(
      json['title'] as String?,
      (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['publisher'] as String?,
      json['description'] as String?,
      (json['categories'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['imageLinks'] == null
          ? null
          : SearchBookImageLinksVO.fromJson(
              json['imageLinks'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchBookVolumeInfoVOToJson(
        SearchBookVolumeInfoVO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'authors': instance.authors,
      'publisher': instance.publisher,
      'description': instance.description,
      'categories': instance.categories,
      'imageLinks': instance.imageLinks,
    };
