import 'package:the_library_app/data/vos/book_overview_list_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';

abstract class LibraryModel {

  /// From Network
  Future<List<BookOverviewListVO>?> getBookOverviewLists();

  Future<List<BookVO>?> getMoreOnOverviewList(String listName, int? offset);

  Future<List<BookVO>?> searchAndGetBooksResult(String query);

  /// From Database
  Future<BookVO?> getBookByTitle(String title);

  Stream<List<BookVO>> getAllVisitedBooksStream();

  void createShelf(ShelfVO shelf);

  Stream<List<ShelfVO>> getAllShelvesStream();

}