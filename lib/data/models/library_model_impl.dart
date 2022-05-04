import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/vos/book_overview_list_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/network/data_agents/library_data_agent.dart';
import 'package:the_library_app/network/data_agents/library_data_agent_retrofit_impl.dart';
import 'package:the_library_app/persistence/daos/book_dao.dart';
import 'package:the_library_app/persistence/daos/impls/book_dao_impl.dart';

class LibraryModelImpl extends LibraryModel {
  static final LibraryModelImpl _singleton = LibraryModelImpl._internal();

  factory LibraryModelImpl() => _singleton;

  LibraryModelImpl._internal();

  /// Data Agents
  final LibraryDataAgent _dataAgent = LibraryDataAgentRetrofitImpl();

  /// Daos
  final BookDao _bookDao = BookDaoImpl();

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
    return Future.value(
      _bookDao.getBookByTitle(title)
    );
  }
}
