import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/view_items/book_grid_item_view.dart';

import 'test_data/test_data.dart';

Future<void> testOperationsInLibrary(WidgetTester tester) async {
  var delayFiveSec = const Duration(seconds: 5);

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

  return Future.value(null);
}
