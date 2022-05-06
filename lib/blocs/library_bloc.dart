import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/models/library_model_impl.dart';
import 'package:the_library_app/data/vos/book_filter_chip_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';

class LibraryBloc extends ChangeNotifier {
  final List<String> sortByFilters = ["Author", "Recent", "Title"];
  final List<String> viewByFilters = ["Grid 3x", "Grid 2x", "List"];

  /// State Variables
  List<BookVO>? myBooks;
  String selectedSortFilter = "Recent";
  String selectedViewFilter = "Grid 3x";
  int selectedTabIndex = 0;
  List<BookFilterChipVO> chipsData = [
    BookFilterChipVO("Ebooks", false),
    BookFilterChipVO("Purchases", false),
    BookFilterChipVO("Samples", false),
    BookFilterChipVO("Downloaded", false),
  ];

  /// Model
  final LibraryModel _libraryModel = LibraryModelImpl();

  LibraryBloc() {
    /// Get Visited Books For Library
    _libraryModel.getAllVisitedBooksStream().listen((visitedBooks) {
      if (selectedSortFilter == sortByFilters[1]) {
        myBooks = visitedBooks;
      } else if (selectedSortFilter == sortByFilters.first) {
        visitedBooks.sort((previous, next) {
          if (previous.author != null && next.author != null) {
            return previous.author!.compareTo(next.author!);
          }
          return 0;
        });
        myBooks = visitedBooks;
      } else {
        visitedBooks.sort((previous, next) {
          if (previous.title != null && next.title != null) {
            return previous.title!.compareTo(next.title!);
          }
          return 0;
        });
        myBooks = visitedBooks;
      }
      notifyListeners();
    }).onError((error) => debugPrint(error.toString()));
  }

  void onTapSortByFilter(String selectedSortFilter) {
    this.selectedSortFilter = selectedSortFilter;
    if (myBooks != null) {
      if (selectedSortFilter == sortByFilters.first) {
        var tempBooksToSort = myBooks!.map((e) => e).toList();
        tempBooksToSort.sort((previous, next) {
          if (previous.author != null && next.author != null) {
            return previous.author!.compareTo(next.author!);
          }
          return 0;
        });
        myBooks = tempBooksToSort;
      } else if (selectedSortFilter == sortByFilters[1]) {
        var tempBooksToSort = myBooks!.map((e) => e).toList();
        tempBooksToSort.sort((previous, next) {
          if (previous.visitedAt != null && next.visitedAt != null) {
            return previous.visitedAt!.compareTo(next.visitedAt!);
          }
          return 0;
        });
        myBooks = tempBooksToSort.reversed.toList();
      } else {
        var tempBooksToSort = myBooks!.map((e) => e).toList();
        tempBooksToSort.sort((previous, next) {
          if (previous.title != null && next.title != null) {
            return previous.title!.compareTo(next.title!);
          }
          return 0;
        });
        myBooks = tempBooksToSort;
      }
    }
    notifyListeners();
  }

  void onTapViewByFilter(String selectedViewFilter) {
    this.selectedViewFilter = selectedViewFilter;
    notifyListeners();
  }

  void onTapTab(int index) {
    selectedTabIndex = index;
    notifyListeners();
  }

  void onTapChip(String label, bool isSelected) {
    chipsData = chipsData.map((originalChipData) {
      if (originalChipData.label == label) {
        originalChipData.isSelected = isSelected;
      }
      return originalChipData;
    }).toList();
    notifyListeners();
  }

  void onTapClearButton() {
    chipsData = chipsData.map((chipData) {
      chipData.isSelected = false;
      return chipData;
    }).toList();
    notifyListeners();
  }
}
