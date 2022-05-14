import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/models/library_model_impl.dart';
import 'package:the_library_app/data/vos/book_vo.dart';

class SearchBloc extends ChangeNotifier {

  /// State Variables
  List<BookVO>? resultBooks = [];

  /// Model
  LibraryModel _libraryModel = LibraryModelImpl();

  SearchBloc([LibraryModel? mLibraryModel]) {
    /// For Testing Purpose
    if (mLibraryModel != null) {
      _libraryModel = mLibraryModel;
    }
  }

  void onSearch(String query) {
    _libraryModel.searchAndGetBooksResult(query).then((result) {
      resultBooks = result;
      notifyListeners();
    }).catchError((error) => debugPrint(error.toString()));
  }

  void onSearchWithEmptyQuery() {
    resultBooks = [];
    notifyListeners();
  }

}