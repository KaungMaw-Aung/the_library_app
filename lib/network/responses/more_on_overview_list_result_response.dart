import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/data/vos/book_vo.dart';

part 'more_on_overview_list_result_response.g.dart';

@JsonSerializable()
class MoreOnOverviewListResultResponse {
  @JsonKey(name: "book_details")
  List<BookVO>? bookDetails;

  MoreOnOverviewListResultResponse(this.bookDetails);

  factory MoreOnOverviewListResultResponse.fromJson(
          Map<String, dynamic> json) =>
      _$MoreOnOverviewListResultResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MoreOnOverviewListResultResponseToJson(this);
}
