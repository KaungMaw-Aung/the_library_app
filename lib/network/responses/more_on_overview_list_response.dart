import 'package:json_annotation/json_annotation.dart';
import 'more_on_overview_list_result_response.dart';

part 'more_on_overview_list_response.g.dart';

@JsonSerializable()
class MoreOnOverviewListResponse {

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "results")
  List<MoreOnOverviewListResultResponse>? results;

  MoreOnOverviewListResponse(this.status, this.results);

  factory MoreOnOverviewListResponse.fromJson(
      Map<String, dynamic> json) =>
      _$MoreOnOverviewListResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MoreOnOverviewListResponseToJson(this);
}