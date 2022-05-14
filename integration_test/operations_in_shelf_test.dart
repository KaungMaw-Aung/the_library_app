import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/pages/add_to_shelf_page.dart';
import 'package:the_library_app/pages/create_new_shelf_page.dart';
import 'package:the_library_app/pages/library_page.dart';
import 'package:the_library_app/pages/shelf_details_page.dart';
import 'package:the_library_app/view_items/book_grid_item_view.dart';
import 'package:the_library_app/view_items/book_shelf_view.dart';

import 'test_data/test_data.dart';

Future<void> testOperationsInShelf(WidgetTester tester) async {
  var delayFiveSec = const Duration(seconds: 5);

  /// tap your shelves tab
  await tester.tap(find.text(YOUR_SHELVES));
  await tester.pumpAndSettle(delayFiveSec);

  /// check there is no shelf created
  expect(find.byType(BookShelfView), findsNothing);

  /// check create shelf button visible
  expect(find.text(CREATE_NEW), findsOneWidget);

  /// tap create shelf button
  await tester.tap(find.text(CREATE_NEW));
  await tester.pumpAndSettle(delayFiveSec);

  /// check if create shelf page appeared
  expect(find.byType(CreateNewShelfPage), findsOneWidget);

  /// tap confirm button
  await tester.tap(find.byKey(const Key(CREATE_SHELF_KEY)));
  await tester.pumpAndSettle(delayFiveSec);

  /// check if empty shelf name warning bottom sheet appeared
  expect(find.text(COULD_NOT_CREATE_THIS_SHELF), findsOneWidget);
  expect(find.text(ENTER_A_SHELF_NAME), findsOneWidget);

  /// tap OK
  await tester.tap(find.text(OK));
  await tester.pumpAndSettle(delayFiveSec);

  /// enter shelf name
  tester.testTextInput.enterText(FIRST_SHELF_NAME);

  /// tap confirm button
  await tester.tap(find.byKey(const Key(CREATE_SHELF_KEY)));
  await tester.pumpAndSettle(delayFiveSec);

  /// check if library page visible
  expect(find.byType(LibraryPage), findsOneWidget);

  /// check recently created shelf is there
  expect(find.byType(BookShelfView), findsOneWidget);

  /// tap the shelf
  await tester.tap(find.text(FIRST_SHELF_NAME));
  await tester.pumpAndSettle(delayFiveSec);

  /// check if shelf detail page appeared
  expect(find.byType(ShelfDetailsPage), findsOneWidget);
  expect(find.text(FIRST_SHELF_NAME), findsOneWidget);
  expect(find.text(EMPTY), findsOneWidget);
  expect(find.text(YOUR_SHELF_IS_EMPTY), findsOneWidget);

  /// tap back button
  await tester.tap(find.byKey(const Key(BACK_BTN_KEY)));
  await tester.pumpAndSettle(delayFiveSec);

  /// check if library page visible
  expect(find.byType(LibraryPage), findsOneWidget);

  /// tap your books tab
  await tester.tap(find.text(YOUR_BOOKS));
  await tester.pumpAndSettle(delayFiveSec);

  /// tap first book's overflow menu and choose add to shelf
  await tester.tap(find.byKey(const Key("$TEST_BOOK_THREE overflow")));
  await tester.pumpAndSettle(delayFiveSec);
  await tester.tap(find.text(ADD_TO_SHELF));
  await tester.pumpAndSettle(delayFiveSec);

  /// check add to shelf page appeared
  expect(find.byType(AddToShelfPage), findsOneWidget);
  expect(find.text(ADD_TO_SHELF), findsOneWidget);
  expect(find.byType(BookShelfView), findsOneWidget);
  expect(find.text(FIRST_SHELF_NAME), findsOneWidget);

  /// choose first shelf
  await tester.tap(find.text(FIRST_SHELF_NAME));
  await tester.pumpAndSettle(delayFiveSec);

  /// tap second book's overflow menu and choose add to shelf
  await tester.tap(find.byKey(const Key("$TEST_BOOK_TWO overflow")));
  await tester.pumpAndSettle(delayFiveSec);
  await tester.tap(find.text(ADD_TO_SHELF));
  await tester.pumpAndSettle(delayFiveSec);

  /// check add to shelf page appeared
  expect(find.byType(AddToShelfPage), findsOneWidget);
  expect(find.text(ADD_TO_SHELF), findsOneWidget);
  expect(find.byType(BookShelfView), findsOneWidget);
  expect(find.text(FIRST_SHELF_NAME), findsOneWidget);

  /// choose first shelf
  await tester.tap(find.text(FIRST_SHELF_NAME));
  await tester.pumpAndSettle(delayFiveSec);

  /// tap third book's overflow menu and choose add to shelf
  await tester.tap(find.byKey(const Key("$TEST_BOOK_ONE overflow")));
  await tester.pumpAndSettle(delayFiveSec);
  await tester.tap(find.text(ADD_TO_SHELF));
  await tester.pumpAndSettle(delayFiveSec);

  /// check add to shelf page appeared
  expect(find.byType(AddToShelfPage), findsOneWidget);
  expect(find.text(ADD_TO_SHELF), findsOneWidget);
  expect(find.byType(BookShelfView), findsOneWidget);
  expect(find.text(FIRST_SHELF_NAME), findsOneWidget);

  /// choose first shelf
  await tester.tap(find.text(FIRST_SHELF_NAME));
  await tester.pumpAndSettle(delayFiveSec);

  /// tap your shelves tab
  await tester.tap(find.text(YOUR_SHELVES));
  await tester.pumpAndSettle(delayFiveSec);

  /// check shelf book count is updated to 3
  expect(find.byType(BookShelfView), findsOneWidget);
  expect(find.text(FIRST_SHELF_NAME), findsOneWidget);
  expect(find.text(TOTAL_BOOKS_IN_SHELF), findsOneWidget);

  /// tap the shelf
  await tester.tap(find.text(FIRST_SHELF_NAME));
  await tester.pumpAndSettle(delayFiveSec);

  /// check if shelf detail page appeared
  expect(find.byType(ShelfDetailsPage), findsOneWidget);
  expect(find.text(FIRST_SHELF_NAME), findsOneWidget);
  expect(find.text(TOTAL_BOOKS_IN_SHELF), findsOneWidget);
  expect(find.text(YOUR_SHELF_IS_EMPTY), findsNothing);
  expect(find.byType(BookGridItemView), findsNWidgets(3));

  /// find two chips
  expect(find.text(CHIP_ONE), findsOneWidget);
  expect(find.text(CHIP_TWO), findsOneWidget);

  /// tap on first chip
  await tester.tap(find.text(CHIP_ONE));
  await tester.pumpAndSettle(delayFiveSec);

  /// check filtered result
  expect(find.text(TEST_BOOK_ONE), findsNothing);
  expect(find.text(TEST_BOOK_TWO), findsNothing);
  expect(find.text(TEST_BOOK_THREE), findsOneWidget);

  /// unselect first chip
  await tester.tap(find.text(CHIP_ONE));
  await tester.pumpAndSettle(delayFiveSec);

  /// check all books appeared
  expect(find.text(TEST_BOOK_ONE), findsOneWidget);
  expect(find.text(TEST_BOOK_TWO), findsOneWidget);
  expect(find.text(TEST_BOOK_THREE), findsOneWidget);

  /// tap on second chip
  await tester.tap(find.text(CHIP_TWO));
  await tester.pumpAndSettle(delayFiveSec);

  /// check filtered result
  expect(find.text(TEST_BOOK_ONE), findsOneWidget);
  expect(find.text(TEST_BOOK_TWO), findsOneWidget);
  expect(find.text(TEST_BOOK_THREE), findsNothing);

  /// tap on first chip
  await tester.tap(find.text(CHIP_ONE));
  await tester.pumpAndSettle(delayFiveSec);

  /// check filtered result
  expect(find.text(TEST_BOOK_ONE), findsOneWidget);
  expect(find.text(TEST_BOOK_TWO), findsOneWidget);
  expect(find.text(TEST_BOOK_THREE), findsOneWidget);

  /// clear selected chips
  await tester.tap(find.byKey(const Key(CLEAR_CHIP)));
  await tester.pumpAndSettle(delayFiveSec);

  /// check unfiltered result
  expect(find.text(TEST_BOOK_ONE), findsOneWidget);
  expect(find.text(TEST_BOOK_TWO), findsOneWidget);
  expect(find.text(TEST_BOOK_THREE), findsOneWidget);

  /// tap sort by options
  await tester.tap(find.text(SORT_BY_RECENT));
  await tester.pumpAndSettle(delayFiveSec);

  /// choose sort by title
  await tester.tap(find.text(TITLE));
  await tester.pumpAndSettle(delayFiveSec);

  /// check if items are sorted by title
  var sortedByTitleResults = tester.widgetList<BookGridItemView>(
    find.byType(BookGridItemView),
  );
  expect(
    sortedByTitleResults.first.key == const Key(TEST_BOOK_ONE) &&
        sortedByTitleResults.elementAt(1).key == const Key(TEST_BOOK_TWO) &&
        sortedByTitleResults.last.key == const Key(TEST_BOOK_THREE),
    true,
  );

  /// tap sort by options
  await tester.tap(find.text(SORT_BY_TITLE));
  await tester.pumpAndSettle(delayFiveSec);

  /// choose sort by author
  await tester.tap(find.text(AUTHOR));
  await tester.pumpAndSettle(delayFiveSec);

  /// check if items are sorted by author
  var sortedByAuthorResults = tester.widgetList<BookGridItemView>(
    find.byType(BookGridItemView),
  );
  expect(
    sortedByAuthorResults.first.key == const Key(TEST_BOOK_THREE) &&
        sortedByAuthorResults.elementAt(1).key == const Key(TEST_BOOK_TWO) &&
        sortedByAuthorResults.last.key == const Key(TEST_BOOK_ONE),
    true,
  );

  /// tap sort by options
  await tester.tap(find.text(SORT_BY_AUTHOR));
  await tester.pumpAndSettle(delayFiveSec);

  /// choose sort by recent
  await tester.tap(find.text(RECENT));
  await tester.pumpAndSettle(delayFiveSec);

  /// check if items are sorted by recent
  var sortedByRecentResults = tester.widgetList<BookGridItemView>(
    find.byType(BookGridItemView),
  );
  expect(
    sortedByRecentResults.first.key == const Key(TEST_BOOK_THREE) &&
        sortedByRecentResults.elementAt(1).key == const Key(TEST_BOOK_TWO) &&
        sortedByRecentResults.last.key == const Key(TEST_BOOK_ONE),
    true,
  );

  /// tap view by options
  await tester.tap(find.text(VIEW_BY_LARGE_GRID));
  await tester.pumpAndSettle(delayFiveSec);

  /// choose view by list
  await tester.tap(find.text(LIST));
  await tester.pumpAndSettle(delayFiveSec);

  /// check layout has changed to List View
  expect(find.byKey(const Key(GRID_VIEW_KEY)), findsNothing);
  expect(find.byKey(const Key(LIST_VIEW_KEY)), findsOneWidget);

  /// tap view by options
  await tester.tap(find.text(VIEW_BY_LIST));
  await tester.pumpAndSettle(delayFiveSec);

  /// choose view by grid 2x
  await tester.tap(find.text(SMALL_GRID));
  await tester.pumpAndSettle(delayFiveSec);

  /// check layout has changed to Grid 2x View
  expect(find.byKey(const Key(LIST_VIEW_KEY)), findsNothing);
  expect(find.byKey(const Key(GRID_VIEW_KEY)), findsOneWidget);

  /// tap view by options
  await tester.tap(find.text(VIEW_BY_SMALL_GRID));
  await tester.pumpAndSettle(delayFiveSec);

  /// choose view by grid 3x
  await tester.tap(find.text(LARGE_GRID));
  await tester.pumpAndSettle(delayFiveSec);

  /// check layout has changed to Grid 3x View
  expect(find.byKey(const Key(LIST_VIEW_KEY)), findsNothing);
  expect(find.byKey(const Key(GRID_VIEW_KEY)), findsOneWidget);

  /// tap on shelf overflow menu
  await tester.tap(find.byKey(const Key(SHELF_OVERFLOW_MENU_KEY)));
  await tester.pumpAndSettle(delayFiveSec);

  /// check shelf options bottom sheet appeared
  expect(find.text(RENAME_SHELF), findsOneWidget);
  expect(find.text(DELETE_SHELF), findsOneWidget);

  /// choose rename shelf
  await tester.tap(find.text(RENAME_SHELF));
  await tester.pumpAndSettle(delayFiveSec);

  /// check text field and confirm rename button appeared
  expect(find.byKey(const Key(CONFIRM_RENAME_BTN_KEY)), findsOneWidget);
  expect(find.byType(TextField), findsOneWidget);

  /// rename shelf
  tester.testTextInput.enterText(SECOND_SHELF_NAME);
  await tester.tap(find.byKey(const Key(RENAME_KEY)));
  await tester.pumpAndSettle(delayFiveSec);

  /// check if shelf name has changed
  expect(find.text(FIRST_SHELF_NAME), findsNothing);
  expect(find.text(SECOND_SHELF_NAME), findsOneWidget);
  expect(find.text(TOTAL_BOOKS_IN_SHELF), findsOneWidget);

  /// tap first book's overflow menu and choose remove from shelf
  await tester.tap(find.byKey(const Key("$TEST_BOOK_THREE overflow")));
  await tester.pumpAndSettle(delayFiveSec);
  await tester.tap(find.text(REMOVE_FROM_SHELF));
  await tester.pumpAndSettle(delayFiveSec);

  /// check only two books left in shelf
  expect(find.byType(BookGridItemView), findsNWidgets(2));
  expect(find.text(TEST_BOOK_THREE), findsNothing);

  /// tap on shelf overflow menu again
  await tester.tap(find.byKey(const Key(SHELF_OVERFLOW_MENU_KEY)));
  await tester.pumpAndSettle(delayFiveSec);

  /// check shelf options bottom sheet appeared
  expect(find.text(RENAME_SHELF), findsOneWidget);
  expect(find.text(DELETE_SHELF), findsOneWidget);

  /// choose delete shelf
  await tester.tap(find.text(DELETE_SHELF));
  await tester.pumpAndSettle(delayFiveSec);

  /// check if library page appeared with no shelf
  expect(find.byType(LibraryPage), findsOneWidget);
  expect(find.byType(BookShelfView), findsNothing);
  expect(find.text(FIRST_SHELF_NAME), findsNothing);
  expect(find.text(SECOND_SHELF_NAME), findsNothing);

  return Future.value(null);
}