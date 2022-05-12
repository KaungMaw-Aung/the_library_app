import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/models/library_model_impl.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';

class ShelfDetailsBloc extends ChangeNotifier {

  /// State Variables
  ShelfVO? shelf;
  List<BookVO>? books;
  bool showShelfEditViews = false;

  /// Model
  final LibraryModel _libraryModel = LibraryModelImpl();

  ShelfDetailsBloc(String shelfId) {

    /// Getting Shelf Detail Stream
    _libraryModel.getShelfStreamById(shelfId).listen((value) {
      shelf = value;
      books = value?.books;
      notifyListeners();
    }).onError((error) => debugPrint(error.toString()));

  }

  void onTapEditShelf() {
    showShelfEditViews = true;
    notifyListeners();
  }

  void doneEditShelf() {
    showShelfEditViews = false;
    notifyListeners();
  }

  void updateShelfName(String shelfId, String updatedName) {
    _libraryModel.updateShelfNameById(shelfId, updatedName);
  }

  void deleteShelfById(String shelfId) {
    _libraryModel.deleteShelfById(shelfId);
  }

}