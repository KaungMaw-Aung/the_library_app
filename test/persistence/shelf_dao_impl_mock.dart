import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/persistence/daos/shelf_dao.dart';

import '../mock_data/mock_data.dart';

class ShelfDaoImplMock extends ShelfDao {

  Map<String, ShelfVO> shelvesFromDatabase = {};

  @override
  void addBookToShelf(String shelfId, BookVO book) {
    shelvesFromDatabase[shelfId]?.books.add(book);
  }

  @override
  void createShelf(ShelfVO shelf) {
    shelvesFromDatabase[shelf.id] = shelf;
  }

  @override
  void deleteShelfById(String shelfId) {
    shelvesFromDatabase.remove(shelfId);
  }

  @override
  Stream<void> getAllEventsFromShelfBox() {
    return Stream<void>.value(null);
  }

  @override
  List<ShelfVO> getAllShelves() {
    return getMockShelves();
  }

  @override
  Stream<List<ShelfVO>> getAllShelvesStream() {
    return Stream.value(getAllShelves());
  }

  @override
  ShelfVO? getShelfById(String shelfId) {
    return getMockShelves().firstWhere((element) => element.id == shelfId);
  }

  @override
  Stream<ShelfVO?> getShelfStreamById(String shelfId) {
    return Stream.value(getShelfById(shelfId));
  }

  @override
  void updateShelfNameById(String shelfId, String shelfName) {
    shelvesFromDatabase[shelfId]?.name = shelfName;
  }

}