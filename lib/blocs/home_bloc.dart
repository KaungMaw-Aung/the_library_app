import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/models/library_model_impl.dart';
import 'package:the_library_app/data/vos/book_overview_list_vo.dart';

class HomeBloc extends ChangeNotifier {
  /// Model
  final LibraryModel _libraryModel = LibraryModelImpl();

  /// State Variables
  int selectedTabIndex = 0;
  List<BookOverviewListVO>? bookOverviewLists;

  HomeBloc() {
    /// Get Book Overview Lists
    _libraryModel.getBookOverviewLists().then((bookOverviewLists) {
      this.bookOverviewLists = bookOverviewLists;
      notifyListeners();
    }).catchError((error) => debugPrint(error.toString()));
  }

  void onTapTab(int index) {
    selectedTabIndex = index;
    notifyListeners();
  }
}
