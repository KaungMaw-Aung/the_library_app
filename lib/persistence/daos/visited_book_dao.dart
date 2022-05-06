import 'package:the_library_app/data/vos/book_vo.dart';

abstract class VisitedBookDao {

  void saveVisitedBook(BookVO book);

  List<BookVO> getAllVisitedBooks();

  Stream<void> getAllEventsFromVisitedBookBox();

  Stream<List<BookVO>> getAllVisitedBooksStream();

}