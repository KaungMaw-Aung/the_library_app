import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/data/vos/search_book_image_links_vo.dart';

part 'search_book_volume_info_vo.g.dart';

@JsonSerializable()
class SearchBookVolumeInfoVO {
  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "authors")
  List<String>? authors;

  @JsonKey(name: "publisher")
  String? publisher;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "categories")
  List<String>? categories;

  @JsonKey(name: "imageLinks")
  SearchBookImageLinksVO? imageLinks;

  SearchBookVolumeInfoVO(
    this.title,
    this.authors,
    this.publisher,
    this.description,
    this.categories,
    this.imageLinks,
  );

  factory SearchBookVolumeInfoVO.fromJson(Map<String, dynamic> json) =>
      _$SearchBookVolumeInfoVOFromJson(json);

  Map<String, dynamic> toJson() => _$SearchBookVolumeInfoVOToJson(this);

}
