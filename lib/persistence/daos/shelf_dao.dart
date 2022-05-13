import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';

abstract class ShelfDao {

  void createShelf(ShelfVO shelf);

  List<ShelfVO> getAllShelves();

  ShelfVO? getShelfById(String shelfId);

  void updateShelfNameById(String shelfId, String shelfName);

  Stream<void> getAllEventsFromShelfBox();

  Stream<List<ShelfVO>> getAllShelvesStream();

  Stream<ShelfVO?> getShelfStreamById(String shelfId);

  void deleteShelfById(String shelfId);

  void addBookToShelf(String shelfId, BookVO book);

}