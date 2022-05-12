import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/models/library_model_impl.dart';
import 'package:the_library_app/data/vos/book_filter_chip_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';

class LibraryBloc extends ChangeNotifier {
  final List<String> sortByFilters = ["Author", "Recent", "Title"];
  final List<String> viewByFilters = ["Grid 3x", "Grid 2x", "List"];

  /// To preserve selected chips order
  List<BookFilterChipVO> selectedChips = [];

  /// To preserve unselected chips order
  List<BookFilterChipVO> chipsInOriginalOrder = [];

  /// To keep visited books
  late List<BookVO> visitedBooksIntact;

  /// State Variables
  List<BookVO>? myBooks;
  String selectedSortFilter = "Recent";
  String selectedViewFilter = "Grid 3x";
  int selectedTabIndex = 0;
  List<BookFilterChipVO>? chipsData;
  List<ShelfVO>? shelves;

  /// Model
  final LibraryModel _libraryModel = LibraryModelImpl();

  LibraryBloc() {
    /// Get Visited Books For Library
    _libraryModel.getAllVisitedBooksStream().listen((visitedBooks) {
      if (chipsData == null) {
        getCategoryChipsFromVisitedBooks(visitedBooks);
      }
      if (selectedSortFilter == sortByFilters[1]) {
        myBooks = _sortByRecent(
          _filterBooksByCategories(
            selectedChips.map((e) => e.label).toList(),
            visitedBooks,
          ),
        );
        visitedBooksIntact = visitedBooks;
      } else if (selectedSortFilter == sortByFilters.first) {
        myBooks = _sortByAuthor(
          _filterBooksByCategories(
            selectedChips.map((e) => e.label).toList(),
            visitedBooks,
          ),
        );
      } else {
        myBooks = _sortByTitle(
          _filterBooksByCategories(
            selectedChips.map((e) => e.label).toList(),
            visitedBooks,
          ),
        );
      }
      notifyListeners();
    }).onError((error) => debugPrint(error.toString()));

    /// Get Shelves
    _libraryModel.getAllShelvesStream().listen((shelves) {
      this.shelves = _sortShelvesByRecent(shelves);
      notifyListeners();
    }).onError((error) => debugPrint(error.toString()));

  }

  void getCategoryChipsFromVisitedBooks(List<BookVO> books) {
    chipsData = books
        .map((book) => book.category ?? "")
        .toSet()
        .map((category) => BookFilterChipVO(category, false))
        .toList();
    chipsInOriginalOrder = chipsData?.map((e) => e).toList() ?? [];
    notifyListeners();
  }

  void onTapSortByFilter(String selectedSortFilter) {
    this.selectedSortFilter = selectedSortFilter;
    if (myBooks != null) {
      if (selectedSortFilter == sortByFilters.first) {
        myBooks = _sortByAuthor(myBooks!.map((e) => e).toList());
      } else if (selectedSortFilter == sortByFilters[1]) {
        myBooks = _sortByRecent(myBooks!.map((e) => e).toList());
      } else {
        myBooks = _sortByTitle(myBooks!.map((e) => e).toList());
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
    /// Handling Chips Orders
    if (isSelected) {
      selectedChips.add(
          chipsInOriginalOrder.firstWhere((element) => element.label == label));
    } else {
      selectedChips.remove(
          chipsInOriginalOrder.firstWhere((element) => element.label == label));
    }
    chipsInOriginalOrder.forEach((originalChipData) {
      if (originalChipData.label == label) {
        originalChipData.isSelected = isSelected;
      }
    });
    chipsData = [
      ...selectedChips,
      ...chipsInOriginalOrder.where((element) => element.isSelected == false)
    ];

    /// Handling Filtered Books Sorting
    if (selectedChips.isNotEmpty) {
      if (selectedSortFilter == sortByFilters.first) {
        myBooks = _sortByAuthor(
          _filterBooksByCategories(
            selectedChips.map((e) => e.label).toList(),
            visitedBooksIntact,
          ),
        );
      } else if (selectedSortFilter == sortByFilters[1]) {
        myBooks = _sortByRecent(
          _filterBooksByCategories(
            selectedChips.map((e) => e.label).toList(),
            visitedBooksIntact,
          ),
        );
      } else {
        myBooks = _sortByTitle(
          _filterBooksByCategories(
            selectedChips.map((e) => e.label).toList(),
            visitedBooksIntact,
          ),
        );
      }
    } else {
      if (selectedSortFilter == sortByFilters.first) {
        myBooks = _sortByAuthor(visitedBooksIntact);
      } else if (selectedSortFilter == sortByFilters[1]) {
        myBooks = _sortByRecent(visitedBooksIntact);
      } else {
        myBooks = _sortByTitle(visitedBooksIntact);
      }
    }

    notifyListeners();
  }

  void onTapClearButton() {
    selectedChips = [];
    chipsInOriginalOrder.forEach((element) {
      element.isSelected = false;
    });
    chipsData = chipsInOriginalOrder.map((e) => e).toList();
    if (selectedSortFilter == sortByFilters.first) {
      myBooks = _sortByAuthor(visitedBooksIntact);
    } else if (selectedSortFilter == sortByFilters[1]) {
      myBooks = _sortByRecent(visitedBooksIntact);
    } else {
      myBooks = _sortByTitle(visitedBooksIntact);
    }
    notifyListeners();
  }

  List<BookVO> _sortByAuthor(List<BookVO> booksToSort) {
    booksToSort.sort((previous, next) {
      if (previous.author != null && next.author != null) {
        return previous.author!.compareTo(next.author!);
      }
      return 0;
    });
    return booksToSort;
  }

  List<BookVO> _sortByTitle(List<BookVO> booksToSort) {
    booksToSort.sort((previous, next) {
      if (previous.title != null && next.title != null) {
        return previous.title!.compareTo(next.title!);
      }
      return 0;
    });
    return booksToSort;
  }

  List<BookVO> _sortByRecent(List<BookVO> booksToSort) {
    booksToSort.sort((previous, next) {
      if (previous.visitedAt != null && next.visitedAt != null) {
        return previous.visitedAt!.compareTo(next.visitedAt!);
      }
      return 0;
    });
    return booksToSort.reversed.toList();
  }

  List<ShelfVO> _sortShelvesByRecent(List<ShelfVO> shelvesToSort) {
    shelvesToSort.sort((previous, next) {
      return previous.createdAt.compareTo(next.createdAt);
    });
    return shelvesToSort;
  }

  List<BookVO> _filterBooksByCategories(
    List<String> categories,
    List<BookVO> books,
  ) {
    if (categories.isNotEmpty) {
      return books.where((myBook) {
        return categories.contains(myBook.category);
      }).toList();
    } else {
      return books;
    }
  }
}
