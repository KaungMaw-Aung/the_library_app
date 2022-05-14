import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/models/library_model_impl.dart';
import 'package:the_library_app/data/vos/book_overview_list_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';

class HomeBloc extends ChangeNotifier {
  /// Model
  LibraryModel _libraryModel = LibraryModelImpl();

  /// State Variables
  int selectedTabIndex = 0;
  List<BookOverviewListVO>? bookOverviewLists;
  List<BookVO>? carouselBooks;

  HomeBloc([LibraryModel? mLibraryModel]) {

    /// For Testing Purpose
    if (mLibraryModel != null) {
      _libraryModel = mLibraryModel;
    }

    /// Get Book Overview Lists
    _libraryModel.getBookOverviewLists().then((bookOverviewLists) {
      this.bookOverviewLists = bookOverviewLists;
      notifyListeners();
    }).catchError((error) => debugPrint(error.toString()));

    /// Get Visited Books For Carousel
    _libraryModel.getAllVisitedBooksStream().listen((visitedBooks) {
      carouselBooks = visitedBooks;
      notifyListeners();
    }).onError((error) => debugPrint(error.toString()));

  }

  void onTapTab(int index) {
    selectedTabIndex = index;
    notifyListeners();
  }
}
