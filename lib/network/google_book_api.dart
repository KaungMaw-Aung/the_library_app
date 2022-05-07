import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:the_library_app/network/responses/searched_books_response.dart';

import 'api_constants.dart';

part 'google_book_api.g.dart';

@RestApi(baseUrl: GOOGLE_API_BASE_URL_DIO)
abstract class GoogleBookApi {
  factory GoogleBookApi(Dio dio) = _GoogleBookApi;

  @GET(ENDPOINT_SEARCH_BOOKS)
  Future<SearchedBooksResponse> searchAndGetBooksResult(
    @Query(PARAM_QUERY) String query,
  );
}
