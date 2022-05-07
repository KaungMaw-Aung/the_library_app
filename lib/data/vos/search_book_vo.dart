import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/data/vos/search_book_volume_info_vo.dart';

part 'search_book_vo.g.dart';

@JsonSerializable()
class SearchBookVO {

  @JsonKey(name: "volumeInfo")
  SearchBookVolumeInfoVO? volumeInfo;

  SearchBookVO(this.volumeInfo);

  factory SearchBookVO.fromJson(Map<String, dynamic> json) =>
      _$SearchBookVOFromJson(json);

  Map<String, dynamic> toJson() => _$SearchBookVOToJson(this);

  BookVO convertToBookVO() {
    return BookVO(
      volumeInfo?.imageLinks?.thumbnail,
      volumeInfo?.title,
      volumeInfo?.authors?.join(", "),
      volumeInfo?.description,
      null,
      volumeInfo?.publisher,
      null,
      volumeInfo?.categories?.first,
    );
  }

}