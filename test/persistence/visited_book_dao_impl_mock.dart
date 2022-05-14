import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/persistence/daos/visited_book_dao.dart';

import '../mock_data/mock_data.dart';

class VisitedBookDaoImplMock extends VisitedBookDao {

  Map<String, BookVO> visitedBooksFromDatabase = {};

  @override
  Stream<void> getAllEventsFromVisitedBookBox() {
    return Stream<void>.value(null);
  }

  @override
  List<BookVO> getAllVisitedBooks() {
    return getMockBooks();
  }

  @override
  Stream<List<BookVO>> getAllVisitedBooksStream() {
    return Stream.value(getAllVisitedBooks());
  }

  @override
  void saveVisitedBook(BookVO book) {
    visitedBooksFromDatabase[book.title ?? ""] = book;
  }

}