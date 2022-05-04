import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/data/vos/book_overview_list_vo.dart';

part 'book_overview_lists_result_response.g.dart';

@JsonSerializable()
class BookOverviewListsResultResponse {

  @JsonKey(name: "lists")
  List<BookOverviewListVO>? lists;

  BookOverviewListsResultResponse(this.lists);

  factory BookOverviewListsResultResponse.fromJson(Map<String, dynamic> json) =>
      _$BookOverviewListsResultResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookOverviewListsResultResponseToJson(this);

}