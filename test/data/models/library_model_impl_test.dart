import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/data/models/library_model_impl.dart';

import '../../mock_data/mock_data.dart';
import '../../network/library_data_agent_retrofit_impl_mock.dart';
import '../../persistence/book_dao_impl_mock.dart';
import '../../persistence/shelf_dao_impl_mock.dart';
import '../../persistence/visited_book_dao_impl_mock.dart';

void main() {
  group("Library Model Unit Tests", () {
    var libraryModel = LibraryModelImpl();

    setUp(() {
      libraryModel.setUpDaosAndDataAgents(
        LibraryDataAgentRetrofitImplMock(),
        BookDaoImplMock(),
        VisitedBookDaoImplMock(),
        ShelfDaoImplMock(),
      );
    });

    test("get book overview lists test", () {
      expect(
        libraryModel.getBookOverviewLists(),
        completion(equals(getMockBookOverviewLists())),
      );
    });

    test("get more on overview list test", () async {
      expect(
        libraryModel.getMoreOnOverviewList("comedy", null),
        completion(equals(getMockBookOverviewLists().first.books)),
      );
    });

    test("search and get books result test", () {
      expect(
        libraryModel.searchAndGetBooksResult("comedy"),
        completion(equals(getMockBooks())),
      );
    });

    test("get book by title test", () {
      expect(
        libraryModel.getBookByTitle("Result Book Three"),
        completion(equals(getMockBooks()[2])),
      );
    });

    test("get all visited books stream test", () {
      expect(
        libraryModel.getAllVisitedBooksStream(),
        emits(getMockBooks()),
      );
    });

    test("get all shelves stream test", () {
      expect(
        libraryModel.getAllShelvesStream(),
        emits(getMockShelves()),
      );
    });

    test("get shelf by id test", () {
      expect(
        libraryModel.getShelfById("0"),
        completion(equals(getMockShelves().first)),
      );
    });

    test("get shelf stream by id test", () {
      expect(
        libraryModel.getShelfStreamById("0"),
        emits(getMockShelves().first),
      );
    });

  });
}
