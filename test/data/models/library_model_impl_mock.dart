import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/vos/book_overview_list_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';

import '../../mock_data/mock_data.dart';

class LibraryModelImplMock extends LibraryModel {

  @override
  void addBookToShelf(String shelfId, BookVO book) {
    // no need to mock
  }

  @override
  void createShelf(ShelfVO shelf) {
    // no need to mock
  }

  @override
  void deleteShelfById(String shelfId) {
    // no need to mock
  }

  @override
  Stream<List<ShelfVO>> getAllShelvesStream() {
    return Stream.value(getMockShelves());
  }

  @override
  Stream<List<BookVO>> getAllVisitedBooksStream() {
    return Stream.value(getMockBooks());
  }

  @override
  Future<BookVO?> getBookByTitle(String title) {
    var result = getMockBooks().where((element) => element.title == title);
    if (result.isNotEmpty) {
      return Future.value(result.first);
    } else {
      return Future.value(null);
    }
  }

  @override
  Future<List<BookOverviewListVO>?> getBookOverviewLists() {
    return Future.value(getMockBookOverviewLists());
  }

  @override
  Future<List<BookVO>?> getMoreOnOverviewList(String listName, int? offset) {
    return Future.value(getMockBookOverviewLists().first.books);
  }

  @override
  Future<ShelfVO?> getShelfById(String shelfId) {
    var result = getMockShelves().where((element) => element.id == shelfId);
    if (result.isNotEmpty) {
      return Future.value(result.first);
    } else {
      return Future.value(null);
    }
  }

  @override
  Stream<ShelfVO?> getShelfStreamById(String shelfId) {
    var result = getMockShelves().where((element) => element.id == shelfId);
    if (result.isNotEmpty) {
      return Stream.value(result.first);
    } else {
      return Stream.value(null);
    }
  }

  @override
  Future<List<BookVO>?> searchAndGetBooksResult(String query) {
    return Future.value(getMockBooks());
  }

  @override
  void updateShelfNameById(String shelfId, String shelfName) {
    // no need to mock
  }

}