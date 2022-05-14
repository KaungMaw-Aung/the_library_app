import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/persistence/persistence_constants.dart';

part 'book_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_BOOK_VO, adapterName: "BookVOAdapter")
class BookVO {
  @JsonKey(name: "book_image")
  @HiveField(0)
  String? cover;

  @JsonKey(name: "title")
  @HiveField(1)
  String? title;

  @JsonKey(name: "author")
  @HiveField(2)
  String? author;

  @JsonKey(name: "description")
  @HiveField(3)
  String? description;

  @JsonKey(name: "price")
  @HiveField(4)
  String? price;

  @JsonKey(name: "publisher")
  @HiveField(5)
  String? publisher;

  @HiveField(6)
  DateTime? visitedAt;

  @HiveField(7)
  String? category;

  BookVO(
    this.cover,
    this.title,
    this.author,
    this.description,
    this.price,
    this.publisher,
    this.visitedAt,
    this.category,
  );

  factory BookVO.fromJson(Map<String, dynamic> json) =>
      _$BookVOFromJson(json);

  Map<String, dynamic> toJson() => _$BookVOToJson(this);


  @override
  String toString() {
    return 'BookVO{cover: $cover, title: $title, author: $author, description: $description, price: $price, publisher: $publisher, category: $category}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookVO &&
          runtimeType == other.runtimeType &&
          cover == other.cover &&
          title == other.title &&
          author == other.author &&
          description == other.description &&
          price == other.price &&
          publisher == other.publisher &&
          category == other.category;

  @override
  int get hashCode =>
      cover.hashCode ^
      title.hashCode ^
      author.hashCode ^
      description.hashCode ^
      price.hashCode ^
      publisher.hashCode ^
      category.hashCode;
}
