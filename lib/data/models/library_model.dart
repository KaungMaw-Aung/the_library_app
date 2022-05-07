import 'package:the_library_app/data/vos/book_overview_list_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';

abstract class LibraryModel {

  /// From Network
  Future<List<BookOverviewListVO>?> getBookOverviewLists();

  Future<List<BookVO>?> getMoreOnOverviewList(String listName, int? offset);

  /// From Database
  Future<BookVO?> getBookByTitle(String title);

  Stream<List<BookVO>> getAllVisitedBooksStream();

  Future<List<BookVO>?> searchAndGetBooksResult(String query);



}