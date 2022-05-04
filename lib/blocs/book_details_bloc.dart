import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/models/library_model_impl.dart';
import 'package:the_library_app/data/vos/book_vo.dart';

class BookDetailsBloc extends ChangeNotifier {

  /// State Variables
  BookVO? book;

  /// Model
  final LibraryModel _libraryModel = LibraryModelImpl();

  BookDetailsBloc(String title) {

    /// Get Book Details by Title from Database
    _libraryModel.getBookByTitle(title).then((book) {
      this.book = book;
      notifyListeners();
    }).catchError((error) => debugPrint(error.toString()));

  }

}