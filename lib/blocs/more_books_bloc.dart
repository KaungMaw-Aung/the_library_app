import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/models/library_model_impl.dart';
import 'package:the_library_app/data/vos/book_vo.dart';

class MoreBookBloc extends ChangeNotifier {

  /// State Variables
  List<BookVO>? books;

  /// Model
  final LibraryModel _libraryModel = LibraryModelImpl();

  MoreBookBloc(String listName) {

    /// Get More Books On Overview List
    _libraryModel.getMoreOnOverviewList(listName, 0).then((books) {
      this.books = books;
      notifyListeners();
    }).catchError((error) => debugPrint(error.toString()));

  }

}