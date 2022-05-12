import 'package:hive/hive.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/persistence/daos/book_dao.dart';

import '../../persistence_constants.dart';

class BookDaoImpl extends BookDao {

  static final BookDaoImpl _singleton = BookDaoImpl._internal();

  factory BookDaoImpl() => _singleton;

  BookDaoImpl._internal();

  @override
  void saveAllBooks(List<BookVO> books) async {
    Map<String, BookVO> booksMap = Map.fromIterable(
        books, key: (book) => book.title, value: (book) => book
    );
    await getBookBox().putAll(booksMap);
  }

  @override
  void saveBook(BookVO book) async {
    await getBookBox().put(book.title ?? "", book);
  }

  @override
  BookVO? getBookByTitle(String title) {
    return getBookBox().get(title);
  }

  Box<BookVO> getBookBox() {
    return Hive.box<BookVO>(BOX_NAME_BOOK_VO);
  }

}