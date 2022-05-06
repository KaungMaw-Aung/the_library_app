import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/data/vos/book_vo.dart';

part 'book_overview_list_vo.g.dart';

@JsonSerializable()
class BookOverviewListVO {
  @JsonKey(name: "list_name")
  String? listName;

  @JsonKey(name: "list_name_encoded")
  String? listNameEncoded;

  @JsonKey(name: "books")
  List<BookVO>? books;

  BookOverviewListVO(
    this.listName,
    this.listNameEncoded,
    this.books,
  );

  factory BookOverviewListVO.fromJson(Map<String, dynamic> json) =>
      _$BookOverviewListVOFromJson(json);

  Map<String, dynamic> toJson() => _$BookOverviewListVOToJson(this);
}
