import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/data/vos/search_book_vo.dart';

part 'searched_books_response.g.dart';

@JsonSerializable()
class SearchedBooksResponse {

  @JsonKey(name: "items")
  List<SearchBookVO>? items;

  SearchedBooksResponse(this.items);

  factory SearchedBooksResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchedBooksResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchedBooksResponseToJson(this);

}