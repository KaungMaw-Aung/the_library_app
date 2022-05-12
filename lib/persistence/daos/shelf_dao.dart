import 'package:the_library_app/data/vos/shelf_vo.dart';

abstract class ShelfDao {

  void createShelf(ShelfVO shelf);

  List<ShelfVO> getAllShelves();

  ShelfVO? getShelfById(String shelfId);

  void updateShelfById(ShelfVO shelf);

  Stream<void> getAllEventsFromShelfBox();

  Stream<List<ShelfVO>> getAllShelvesStream();

}