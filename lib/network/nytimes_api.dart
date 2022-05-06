import 'dart:async';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'api_constants.dart';
import 'responses/book_overview_lists_response.dart';
import 'responses/more_on_overview_list_response.dart';

part 'nytimes_api.g.dart';

@RestApi(baseUrl: NYTIMES_BASE_URL_DIO)
abstract class NYTimesApi {
  factory NYTimesApi(Dio dio) = _NYTimesApi;

  @GET(ENDPOINT_GET_BOOK_OVERVIEW_LISTS)
  Future<BookOverviewListsResponse> getBookOverviewLists(
    @Query(PARAM_API_KEY) String apiKey,
  );

  @GET(ENDPOINT_GET_MORE_ON_OVERVIEW_LIST)
  Future<MoreOnOverviewListResponse> getMoreOnOverviewList(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LIST) String listName,
    @Query(PARAM_OFFSET) int? offset,
  );
}
