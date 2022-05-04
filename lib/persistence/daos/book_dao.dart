import 'package:the_library_app/data/vos/book_vo.dart';

abstract class BookDao {

  void saveAllBooks(List<BookVO> books);

  BookVO? getBookByTitle(String title);

}