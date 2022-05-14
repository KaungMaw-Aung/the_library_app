import 'package:stream_transform/stream_transform.dart';
import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/vos/book_overview_list_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/network/data_agents/library_data_agent.dart';
import 'package:the_library_app/network/data_agents/library_data_agent_retrofit_impl.dart';
import 'package:the_library_app/persistence/daos/book_dao.dart';
import 'package:the_library_app/persistence/daos/impls/book_dao_impl.dart';
import 'package:the_library_app/persistence/daos/impls/shelf_dao_impl.dart';
import 'package:the_library_app/persistence/daos/impls/visited_book_dao_impl.dart';
import 'package:the_library_app/persistence/daos/shelf_dao.dart';
import 'package:the_library_app/persistence/daos/visited_book_dao.dart';

class LibraryModelImpl extends LibraryModel {
  static final LibraryModelImpl _singleton = LibraryModelImpl._internal();

  factory LibraryModelImpl() => _singleton;

  LibraryModelImpl._internal();

  /// Data Agents
  LibraryDataAgent _dataAgent = LibraryDataAgentRetrofitImpl();

  /// Daos
  BookDao _bookDao = BookDaoImpl();
  VisitedBookDao _visitedBookDao = VisitedBookDaoImpl();
  ShelfDao _shelfDao = ShelfDaoImpl();

  /// For Testing Purpose
  void setUpDaosAndDataAgents(
    LibraryDataAgent mDataAgent,
    BookDao mBookDao,
    VisitedBookDao mVisitedBookDao,
    ShelfDao mShelfBookDao,
  ) {
    _dataAgent = mDataAgent;
    _bookDao = mBookDao;
    _visitedBookDao = mVisitedBookDao;
    _shelfDao = mShelfBookDao;
  }

  @override
  Future<List<BookOverviewListVO>?> getBookOverviewLists() {
    return _dataAgent
        .getBookOverviewLists()
        .asStream()
        .map((bookOverviewLists) {
      // flatten multiple lists into one
      if (bookOverviewLists != null) {
        var books = bookOverviewLists
            .map((bookOverviewList) {
              bookOverviewList.books?.forEach((book) {
                book.category = bookOverviewList.listName;
              });
              return bookOverviewList;
            })
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
    return _dataAgent
        .getMoreOnOverviewList(listName, offset)
        .asStream()
        .map((books) {
      /// Save books if they were not already in persistence
      return books?.map((book) {
        var resultBook = _bookDao.getBookByTitle(book.title ?? "");
        if (resultBook == null) {
          book.cover =
              "https://www.theyoungfolks.com/wp-content/uploads/2017/08/six-of-crows-770x1156.jpg";
          _bookDao.saveBook(book);
          return book;
        } else {
          return resultBook;
        }
      }).toList();
    }).first;
  }

  @override
  Future<List<BookVO>?> searchAndGetBooksResult(String query) {
    return _dataAgent
        .searchAndGetBooksResult(query)
        .asStream()
        .map((searchResults) {
      searchResults?.forEach((result) {
        var resultBook = _bookDao.getBookByTitle(result.title ?? "");
        if (resultBook == null) {
          _bookDao.saveBook(result);
        }
      });
      return searchResults;
    }).first;
  }

  @override
  void createShelf(ShelfVO shelf) {
    _shelfDao.createShelf(shelf);
  }

  @override
  Stream<List<ShelfVO>> getAllShelvesStream() {
    return _shelfDao
        .getAllEventsFromShelfBox()
        .startWith(_shelfDao.getAllShelvesStream())
        .map((event) => _shelfDao.getAllShelves());
  }

  @override
  Future<ShelfVO?> getShelfById(String shelfId) {
    return Future.value(_shelfDao.getShelfById(shelfId));
  }

  @override
  Stream<ShelfVO?> getShelfStreamById(String shelfId) {
    return _shelfDao
        .getAllEventsFromShelfBox()
        .startWith(_shelfDao.getShelfStreamById(shelfId))
        .map((event) => _shelfDao.getShelfById(shelfId));
  }

  @override
  void updateShelfNameById(String shelfId, String shelfName) {
    _shelfDao.updateShelfNameById(shelfId, shelfName);
  }

  @override
  void deleteShelfById(String shelfId) {
    _shelfDao.deleteShelfById(shelfId);
  }

  @override
  void addBookToShelf(String shelfId, BookVO book) {
    _shelfDao.addBookToShelf(shelfId, book);
  }
}
