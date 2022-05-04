import 'package:the_library_app/data/vos/book_overview_list_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';

abstract class LibraryModel {

  Future<List<BookOverviewListVO>?> getBookOverviewLists();

  Future<BookVO?> getBookByTitle(String title);

}