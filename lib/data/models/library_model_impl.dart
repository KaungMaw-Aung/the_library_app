import 'package:stream_transform/stream_transform.dart';
import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/vos/book_overview_list_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/network/data_agents/library_data_agent.dart';
import 'package:the_library_app/network/data_agents/library_data_agent_retrofit_impl.dart';
import 'package:the_library_app/persistence/daos/book_dao.dart';
import 'package:the_library_app/persistence/daos/impls/book_dao_impl.dart';
import 'package:the_library_app/persistence/daos/impls/visited_book_dao_impl.dart';
import 'package:the_library_app/persistence/daos/visited_book_dao.dart';

class LibraryModelImpl extends LibraryModel {
  static final LibraryModelImpl _singleton = LibraryModelImpl._internal();

  factory LibraryModelImpl() => _singleton;

  LibraryModelImpl._internal();

  /// Data Agents
  final LibraryDataAgent _dataAgent = LibraryDataAgentRetrofitImpl();

  /// Daos
  final BookDao _bookDao = BookDaoImpl();
  final VisitedBookDao _visitedBookDao = VisitedBookDaoImpl();

  @override
  Future<List<BookOverviewListVO>?> getBookOverviewLists() {
    return _dataAgent
        .getBookOverviewLists()
        .asStream()
        .map((bookOverviewLists) {
      // flatten multiple lists into one
      if (bookOverviewLists != null) {
        var books = bookOverviewLists
            .map((value) => value.books ?? [])
            .toList()
            .expand((bookList) => bookList)
            .toList();
        _bookDao.saveAllBooks(books);
      }
      return bookOverviewLists;
    }).first;
  }

  @override
  Future<BookVO?> getBookByTitle(String title) {
    var book = _bookDao.getBookByTitle(title);
    if (book != null) {
      book.visitedAt = DateTime.now();
      _visitedBookDao.saveVisitedBook(book);
    }
    return Future.value(book);
  }

  @override
  Stream<List<BookVO>> getAllVisitedBooksStream() {
    return _visitedBookDao
        .getAllEventsFromVisitedBookBox()
        .startWith(_visitedBookDao.getAllVisitedBooksStream())
        .map((event) => _visitedBookDao.getAllVisitedBooks());
  }

  @override
  Future<List<BookVO>?> getMoreOnOverviewList(String listName, int? offset) {
    return _dataAgent.getMoreOnOverviewList(listName, offset).asStream().map((books) {
      /// Save books if they were not already in persistence
      return books?.map((book) {
        var resultBook = _bookDao.getBookByTitle(book.title ?? "");
        if (resultBook == null) {
          book.cover = "https://www.theyoungfolks.com/wp-content/uploads/2017/08/six-of-crows-770x1156.jpg";
          _bookDao.saveBook(book);
          return book;
        } else {
          return resultBook;
        }
      }).toList();
    }).first;
  }
}
