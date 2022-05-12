import 'package:hive/hive.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/persistence/daos/shelf_dao.dart';

import '../../persistence_constants.dart';

class ShelfDaoImpl extends ShelfDao {

  static final ShelfDaoImpl _singleton = ShelfDaoImpl._internal();

  factory ShelfDaoImpl() => _singleton;

  ShelfDaoImpl._internal();

  @override
  void createShelf(ShelfVO shelf) async {
    await getShelfBox().put(shelf.id, shelf);
  }

  @override
  List<ShelfVO> getAllShelves() {
    return getShelfBox().values.toList();
  }

  @override
  ShelfVO? getShelfById(String shelfId) {
    return getShelfBox().get(shelfId);
  }

  @override
  void updateShelfNameById(String shelfId, String shelfName) async {
    var shelf = getShelfById(shelfId);
    if (shelf != null) {
      shelf.name = shelfName;
      await getShelfBox().put(shelf.id, shelf);
    }
  }

  /// Reactive Programming
  @override
  Stream<void> getAllEventsFromShelfBox() {
    return getShelfBox().watch();
  }

  @override
  Stream<List<ShelfVO>> getAllShelvesStream() {
    return Stream.value(getAllShelves());
  }

  Box<ShelfVO> getShelfBox() {
    return Hive.box<ShelfVO>(BOX_NAME_SHELF_VO);
  }

  @override
  Stream<ShelfVO?> getShelfStreamById(String shelfId) {
    return Stream.value(getShelfById(shelfId));
  }

  @override
  void deleteShelfById(String shelfId) async{
    await getShelfBox().delete(shelfId);
  }

}
