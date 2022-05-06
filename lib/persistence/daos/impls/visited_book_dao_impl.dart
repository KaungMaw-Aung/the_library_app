import 'package:hive/hive.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/persistence/daos/visited_book_dao.dart';

import '../../persistence_constants.dart';

class VisitedBookDaoImpl extends VisitedBookDao {

  static final VisitedBookDaoImpl _singleton = VisitedBookDaoImpl._internal();

  factory VisitedBookDaoImpl() => _singleton;

  VisitedBookDaoImpl._internal();

  @override
  List<BookVO> getAllVisitedBooks() {
    var visitedBooks = getVisitedBookBox().values.toList();
    /// Sort Visited Books on their VisitedAt field
    visitedBooks.sort(
            (previous, next) {
          if (previous.visitedAt != null && next.visitedAt != null) {
            return previous.visitedAt!.compareTo(next.visitedAt!);
          }
          return 0;
        }
    );
    return visitedBooks.reversed.toList();
  }

  @override
  void saveVisitedBook(BookVO book) async {
    await getVisitedBookBox().put(book.title, book);
  }

  /// Reactive Programming
  @override
  Stream<void> getAllEventsFromVisitedBookBox() {
    return getVisitedBookBox().watch();
  }

  @override
  Stream<List<BookVO>> getAllVisitedBooksStream() {
    return Stream.value(getAllVisitedBooks());
  }

  Box<BookVO> getVisitedBookBox() {
    return Hive.box<BookVO>(BOX_NAME_VISITED_BOOK_VO);
  }

}