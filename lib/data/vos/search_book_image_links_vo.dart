import 'package:json_annotation/json_annotation.dart';

part 'search_book_image_links_vo.g.dart';

@JsonSerializable()
class SearchBookImageLinksVO {

  @JsonKey(name: "thumbnail")
  String? thumbnail;

  SearchBookImageLinksVO(this.thumbnail);

  factory SearchBookImageLinksVO.fromJson(Map<String, dynamic> json) =>
      _$SearchBookImageLinksVOFromJson(json);

  Map<String, dynamic> toJson() => _$SearchBookImageLinksVOToJson(this);

}