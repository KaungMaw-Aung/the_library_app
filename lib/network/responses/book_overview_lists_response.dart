import 'package:json_annotation/json_annotation.dart';
import 'book_overview_lists_result_response.dart';

part 'book_overview_lists_response.g.dart';

@JsonSerializable()
class BookOverviewListsResponse {

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "results")
  BookOverviewListsResultResponse? results;

  BookOverviewListsResponse(this.status, this.results);

  factory BookOverviewListsResponse.fromJson(Map<String, dynamic> json) =>
      _$BookOverviewListsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookOverviewListsResponseToJson(this);

}