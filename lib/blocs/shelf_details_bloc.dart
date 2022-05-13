import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/models/library_model_impl.dart';
import 'package:the_library_app/data/vos/book_filter_chip_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';

class ShelfDetailsBloc extends ChangeNotifier {
  final List<String> sortByFilters = ["Author", "Recent", "Title"];
  final List<String> viewByFilters = ["Grid 3x", "Grid 2x", "List"];

  /// To preserve selected chips order
  List<BookFilterChipVO> selectedChips = [];

  /// To preserve unselected chips order
  List<BookFilterChipVO> chipsInOriginalOrder = [];

  /// To keep books
  late List<BookVO> visitedBooksIntact;

  /// State Variables
  ShelfVO? shelf;
  List<BookVO>? books;
  bool showShelfEditViews = false;
  String selectedSortFilter = "Recent";
  String selectedViewFilter = "Grid 3x";
  List<BookFilterChipVO>? chipsData;

  /// Model
  final LibraryModel _libraryModel = LibraryModelImpl();

  ShelfDetailsBloc(String shelfId) {

    /// Getting Shelf Detail Stream
    _libraryModel.getShelfStreamById(shelfId).listen((value) {
      if (chipsData == null) {
        getCategoryChipsFromVisitedBooks(value?.books ?? []);
      }
      if (selectedSortFilter == sortByFilters[1]) {
        books = _sortByRecent(
          _filterBooksByCategories(
            selectedChips.map((e) => e.label).toList(),
            value?.books ?? [],
          ),
        );
      } else if (selectedSortFilter == sortByFilters.first) {
        books = _sortByAuthor(
          _filterBooksByCategories(
            selectedChips.map((e) => e.label).toList(),
            value?.books ?? [],
          ),
        );
      } else {
        books = _sortByTitle(
          _filterBooksByCategories(
            selectedChips.map((e) => e.label).toList(),
            value?.books ?? [],
          ),
        );
      }
      shelf = value;
      visitedBooksIntact = value?.books ?? [];
      notifyListeners();
    }).onError((error) => debugPrint(error.toString()));

  }

  void onTapEditShelf() {
    showShelfEditViews = true;
    notifyListeners();
  }

  void doneEditShelf() {
    showShelfEditViews = false;
    notifyListeners();
  }

  void updateShelfName(String shelfId, String updatedName) {
    _libraryModel.updateShelfNameById(shelfId, updatedName);
  }

  void deleteShelfById(String shelfId) {
    _libraryModel.deleteShelfById(shelfId);
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
    if (books != null) {
      if (selectedSortFilter == sortByFilters.first) {
        books = _sortByAuthor(books!.map((e) => e).toList());
      } else if (selectedSortFilter == sortByFilters[1]) {
        books = _sortByRecent(books!.map((e) => e).toList());
      } else {
        books = _sortByTitle(books!.map((e) => e).toList());
      }
    }
    notifyListeners();
  }

  void onTapViewByFilter(String selectedViewFilter) {
    this.selectedViewFilter = selectedViewFilter;
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
        books = _sortByAuthor(
          _filterBooksByCategories(
            selectedChips.map((e) => e.label).toList(),
            visitedBooksIntact,
          ),
        );
      } else if (selectedSortFilter == sortByFilters[1]) {
        books = _sortByRecent(
          _filterBooksByCategories(
            selectedChips.map((e) => e.label).toList(),
            visitedBooksIntact,
          ),
        );
      } else {
        books = _sortByTitle(
          _filterBooksByCategories(
            selectedChips.map((e) => e.label).toList(),
            visitedBooksIntact,
          ),
        );
      }
    } else {
      if (selectedSortFilter == sortByFilters.first) {
        books = _sortByAuthor(visitedBooksIntact);
      } else if (selectedSortFilter == sortByFilters[1]) {
        books = _sortByRecent(visitedBooksIntact);
      } else {
        books = _sortByTitle(visitedBooksIntact);
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
      books = _sortByAuthor(visitedBooksIntact);
    } else if (selectedSortFilter == sortByFilters[1]) {
      books = _sortByRecent(visitedBooksIntact);
    } else {
      books = _sortByTitle(visitedBooksIntact);
    }
    notifyListeners();
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

  void updateShelf(ShelfVO shelf) {
    _libraryModel.createShelf(shelf);
  }

  void removeBookFromShelf(BookVO? book) {
    shelf?.books.remove(book);
    if (shelf != null) {
      updateShelf(shelf!);
    }
  }

}