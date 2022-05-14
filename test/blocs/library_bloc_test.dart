import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/blocs/library_bloc.dart';
import 'package:the_library_app/data/vos/book_filter_chip_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';

import '../data/models/library_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Library Bloc Test", () {
    LibraryBloc? bloc;

    setUp(() {
      bloc = LibraryBloc(LibraryModelImplMock());
    });

    test("get visited books for library test", () {
      expect(bloc?.chipsData, getMockChips());
      expect(bloc?.chipsInOriginalOrder, getMockChips());
      expect(bloc?.myBooks, getMockBooks().reversed.toList());
      expect(bloc?.visitedBooksIntact, getMockBooks());
    });

    test("get shelves test", () {
      expect(bloc?.shelves, getMockShelves());
    });

    test("on tap sort by filter test", () {
      expect(bloc?.selectedSortFilter, "Recent");

      /// sorted by author
      bloc?.onTapSortByFilter("Author");
      expect(bloc?.selectedSortFilter, "Author");
      expect(
        bloc?.myBooks,
        [
          BookVO(
            "result_book_four_cover.jpg",
            "Result Book Four",
            "Result Author Four",
            "This is result book four.",
            "2.0",
            "Result Book Four Publisher",
            null,
            "Musical",
          ),
          BookVO(
            "result_book_one_cover.jpg",
            "Result Book One",
            "Result Author One",
            "This is result book one.",
            "1.0",
            "Result Book One Publisher",
            null,
            "Comedy",
          ),
          BookVO(
            "result_book_three_cover.jpg",
            "Result Book Three",
            "Result Author Three",
            "This is result book three.",
            "3.0",
            "Result Book Three Publisher",
            null,
            "Sciences",
          ),
          BookVO(
            "result_book_two_cover.jpg",
            "Result Book Two",
            "Result Author Two",
            "This is result book two.",
            "2.0",
            "Result Book Two Publisher",
            null,
            "Education",
          ),
        ],
      );

      /// sorted by title
      bloc?.onTapSortByFilter("Title");
      expect(bloc?.selectedSortFilter, "Title");
      expect(
        bloc?.myBooks,
        [
          BookVO(
            "result_book_four_cover.jpg",
            "Result Book Four",
            "Result Author Four",
            "This is result book four.",
            "2.0",
            "Result Book Four Publisher",
            null,
            "Musical",
          ),
          BookVO(
            "result_book_one_cover.jpg",
            "Result Book One",
            "Result Author One",
            "This is result book one.",
            "1.0",
            "Result Book One Publisher",
            null,
            "Comedy",
          ),
          BookVO(
            "result_book_three_cover.jpg",
            "Result Book Three",
            "Result Author Three",
            "This is result book three.",
            "3.0",
            "Result Book Three Publisher",
            null,
            "Sciences",
          ),
          BookVO(
            "result_book_two_cover.jpg",
            "Result Book Two",
            "Result Author Two",
            "This is result book two.",
            "2.0",
            "Result Book Two Publisher",
            null,
            "Education",
          ),
        ],
      );

      /// sorted by recent
      bloc?.onTapSortByFilter("Recent");
      expect(bloc?.selectedSortFilter, "Recent");
      expect(
        bloc?.myBooks,
        [
          BookVO(
            "result_book_two_cover.jpg",
            "Result Book Two",
            "Result Author Two",
            "This is result book two.",
            "2.0",
            "Result Book Two Publisher",
            null,
            "Education",
          ),
          BookVO(
            "result_book_three_cover.jpg",
            "Result Book Three",
            "Result Author Three",
            "This is result book three.",
            "3.0",
            "Result Book Three Publisher",
            null,
            "Sciences",
          ),
          BookVO(
            "result_book_one_cover.jpg",
            "Result Book One",
            "Result Author One",
            "This is result book one.",
            "1.0",
            "Result Book One Publisher",
            null,
            "Comedy",
          ),
          BookVO(
            "result_book_four_cover.jpg",
            "Result Book Four",
            "Result Author Four",
            "This is result book four.",
            "2.0",
            "Result Book Four Publisher",
            null,
            "Musical",
          ),
        ],
      );

    });

    test("on tap view by filter test", () {
      expect(bloc?.selectedViewFilter, "Grid 3x");
      bloc?.onTapViewByFilter("List");
      expect(bloc?.selectedViewFilter, "List");
    });

    test("on tap tab test", () {
      expect(bloc?.selectedTabIndex, 0);
      bloc?.onTapTab(1);
      expect(bloc?.selectedTabIndex, 1);
    });

    test("on tap chip test", () {
      /// select chip
      bloc?.onTapChip("Musical", true);
      expect(
        bloc?.chipsData,
        [
          BookFilterChipVO("Musical", true),
          BookFilterChipVO("Comedy", false),
          BookFilterChipVO("Education", false),
          BookFilterChipVO("Sciences", false),
        ],
      );
      expect(bloc?.myBooks, [getMockBooks().last]);

      /// unselect chip
      bloc?.onTapChip("Musical", false);
      expect(bloc?.chipsData, getMockChips());
      expect(bloc?.myBooks, getMockBooks().reversed.toList());
    });

    test("on tap clear button test", () {
      /// firstly, choose one chip
      bloc?.onTapChip("Musical", true);
      expect(
        bloc?.chipsData,
        [
          BookFilterChipVO("Musical", true),
          BookFilterChipVO("Comedy", false),
          BookFilterChipVO("Education", false),
          BookFilterChipVO("Sciences", false),
        ],
      );
      expect(bloc?.myBooks, [getMockBooks().last]);

      /// then, clear chips
      bloc?.onTapClearButton();
      expect(bloc?.selectedChips.isEmpty, true);
      expect(bloc?.chipsData, getMockChips());
      expect(bloc?.myBooks, getMockBooks().reversed.toList());
    });
    
  });
}
