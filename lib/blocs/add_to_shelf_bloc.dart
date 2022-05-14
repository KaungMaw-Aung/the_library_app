import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/models/library_model_impl.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';

class AddToShelfBloc extends ChangeNotifier {

  /// State Variables
  List<ShelfVO>? shelves;

  /// Model
  LibraryModel _libraryModel = LibraryModelImpl();

  AddToShelfBloc([LibraryModel? mLibraryModel]) {

    if (mLibraryModel != null) {
      _libraryModel = mLibraryModel;
    }

    /// Get Shelves
    _libraryModel.getAllShelvesStream().listen((shelves) {
      this.shelves = _sortShelvesByRecent(shelves);
      notifyListeners();
    }).onError((error) => debugPrint(error.toString()));

  }

  void addBookToShelf(String shelfId, BookVO? book) {
    if (book != null) {
      _libraryModel.addBookToShelf(shelfId, book);
    }
  }

  List<ShelfVO> _sortShelvesByRecent(List<ShelfVO> shelvesToSort) {
    shelvesToSort.sort((previous, next) {
      return previous.createdAt.compareTo(next.createdAt);
    });
    return shelvesToSort;
  }

}