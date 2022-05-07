import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/models/library_model_impl.dart';
import 'package:the_library_app/data/vos/book_vo.dart';

class MoreBookBloc extends ChangeNotifier {

  late String listName;

  /// State Variables
  List<BookVO>? books;
  int offset = 0;

  /// Model
  final LibraryModel _libraryModel = LibraryModelImpl();

  MoreBookBloc(this.listName) {

    getMoreOnOverviewList(listName, offset);

  }

  void getMoreOnOverviewList(String listName, int offset) {
    _libraryModel.getMoreOnOverviewList(listName, offset).then((books) {
      if (this.books == null) {
        this.books = books;
      } else {
        this.books?.addAll(books ?? []);
      }
      notifyListeners();
    }).catchError((error) => debugPrint(error.toString()));
  }

  void onListEndReached() {
    offset += 20;
    getMoreOnOverviewList(listName, offset);
  }

}