import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/persistence/daos/book_dao.dart';

import '../mock_data/mock_data.dart';

class BookDaoImplMock extends BookDao {
  Map<String, BookVO> booksFromDatabase = {};

  @override
  BookVO? getBookByTitle(String title) {
    var result = getMockBooks().where((element) => element.title == title).toList();
    if (result.isEmpty) {
      return null;
    } else {
      return result.first;
    }
  }

  @override
  void saveAllBooks(List<BookVO> books) {
    books.forEach((book) {
      booksFromDatabase[book.title ?? ""] = book;
    });
  }

  @override
  void saveBook(BookVO book) {
    booksFromDatabase[book.title ?? ""] = book;
  }
}
