import 'package:the_library_app/data/vos/book_overview_list_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/network/data_agents/library_data_agent.dart';

import '../mock_data/mock_data.dart';

class LibraryDataAgentRetrofitImplMock extends LibraryDataAgent {
  @override
  Future<List<BookOverviewListVO>?> getBookOverviewLists() {
    return Future.value(getMockBookOverviewLists());
  }

  @override
  Future<List<BookVO>?> getMoreOnOverviewList(String listName, int? offset) {
    return Future.value(getMockBookOverviewLists()
        .firstWhere((element) => element.listNameEncoded == listName)
        .books);
  }

  @override
  Future<List<BookVO>?> searchAndGetBooksResult(String query) {
    return Future.value(getMockBooks());
  }
}
