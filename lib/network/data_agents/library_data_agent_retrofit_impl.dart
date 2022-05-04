import 'package:dio/dio.dart';
import 'package:the_library_app/data/vos/book_overview_list_vo.dart';
import 'package:the_library_app/network/api_constants.dart';
import 'package:the_library_app/network/data_agents/library_data_agent.dart';
import 'package:the_library_app/network/nytimes_api.dart';

class LibraryDataAgentRetrofitImpl extends LibraryDataAgent {
  late NYTimesApi _nyTimesApi;

  static final LibraryDataAgentRetrofitImpl _singleton =
      LibraryDataAgentRetrofitImpl._internal();

  factory LibraryDataAgentRetrofitImpl() => _singleton;

  LibraryDataAgentRetrofitImpl._internal() {
    Dio dio = Dio();
    _nyTimesApi = NYTimesApi(dio);
  }

  @override
  Future<List<BookOverviewListVO>?> getBookOverviewLists() {
    return _nyTimesApi
        .getBookOverviewLists(NYTIMES_API_KEY)
        .asStream()
        .map((response) => response.results?.lists)
        .first;
  }
}
