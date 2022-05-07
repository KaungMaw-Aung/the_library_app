import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/models/library_model_impl.dart';
import 'package:the_library_app/data/vos/book_vo.dart';

class SearchBloc extends ChangeNotifier {

  /// State Variables
  List<BookVO>? resultBooks = [];

  /// Model
  final LibraryModel _libraryModel = LibraryModelImpl();

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