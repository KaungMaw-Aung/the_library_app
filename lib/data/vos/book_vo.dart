import 'package:json_annotation/json_annotation.dart';

part 'book_vo.g.dart';

@JsonSerializable()
class BookVO {
  @JsonKey(name: "book_image")
  String? cover;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "author")
  String? author;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "price")
  String? price;

  @JsonKey(name: "publisher")
  String? publisher;

  int? createdAt;

  BookVO(
    this.cover,
    this.title,
    this.author,
    this.description,
    this.price,
    this.publisher,
    this.createdAt,
  );

  factory BookVO.fromJson(Map<String, dynamic> json) =>
      _$BookVOFromJson(json);

  Map<String, dynamic> toJson() => _$BookVOToJson(this);

}
