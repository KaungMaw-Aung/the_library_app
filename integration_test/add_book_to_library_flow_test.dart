import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/pages/book_details_page.dart';
import 'package:the_library_app/pages/home_page.dart';

import 'test_data/test_data.dart';

Future<void> testAddBookToLibrary(WidgetTester tester) async {
  var delayFiveSec = const Duration(seconds: 5);

  /// check if Home Page appeared
  expect(find.byType(HomePage), findsOneWidget);
  expect(find.byType(HorizontalBookCarouselView), findsNothing);

  /// tap on one book
  await tester.tap(find.text(TEST_BOOK_ONE).first);
  await tester.pumpAndSettle(delayFiveSec);

  /// check if book detail page appeared
  expect(find.byType(BookDetailsPage), findsOneWidget);
  expect(find.byKey(const Key(BACK_BTN_KEY)), findsOneWidget);

  /// tap back button
  await tester.tap(find.byKey(const Key(BACK_BTN_KEY)));
  await tester.pumpAndSettle(delayFiveSec);

  /// check if Home Page appeared, carousel is visible and recently visited book is there
  expect(find.byType(HomePage), findsOneWidget);
  expect(find.byType(HorizontalBookCarouselView), findsOneWidget);
  expect(find.byKey(const Key(TEST_BOOK_ONE)), findsOneWidget);

  /// tap on one book
  await tester.tap(find.text(TEST_BOOK_TWO).first);
  await tester.pumpAndSettle(delayFiveSec);

  /// check if book detail page appeared
  expect(find.byType(BookDetailsPage), findsOneWidget);
  expect(find.byKey(const Key(BACK_BTN_KEY)), findsOneWidget);

  /// tap back button
  await tester.tap(find.byKey(const Key(BACK_BTN_KEY)));
  await tester.pumpAndSettle(delayFiveSec);

  /// check if Home Page appeared, carousel is visible and two recently visited book are there
  expect(find.byType(HomePage), findsOneWidget);
  expect(find.byType(HorizontalBookCarouselView), findsOneWidget);
  expect(find.byKey(const Key(TEST_BOOK_ONE)), findsOneWidget);
  expect(find.byKey(const Key(TEST_BOOK_TWO)), findsOneWidget);

  /// scroll to see Book 3
  await tester.drag(
    find.byType(Scrollable).first,
    const Offset(0, -300),
  );
  await tester.pumpAndSettle(delayFiveSec);

  /// tap on one book
  await tester.tap(find.text(TEST_BOOK_THREE).first);
  await tester.pumpAndSettle(delayFiveSec);

  /// check if book detail page appeared
  expect(find.byType(BookDetailsPage), findsOneWidget);
  expect(find.byKey(const Key(BACK_BTN_KEY)), findsOneWidget);

  /// tap back button
  await tester.tap(find.byKey(const Key(BACK_BTN_KEY)));
  await tester.pumpAndSettle(delayFiveSec);

  /// scroll back to top
  await tester.drag(
      find.byType(Scrollable).first,
      const Offset(0, 300),
  );
  await tester.pumpAndSettle(delayFiveSec);

  /// check if carousel is visible and three recently visited book are there
  expect(find.byType(HorizontalBookCarouselView), findsOneWidget);
  expect(find.byKey(const Key(TEST_BOOK_THREE)), findsOneWidget);

  /// scroll carousel
  await tester.drag(
      find.byType(HorizontalBookCarouselView),
      const Offset(-200, 0),
  );
  await tester.pumpAndSettle(delayFiveSec);

  expect(find.byKey(const Key(TEST_BOOK_TWO)), findsOneWidget);

  /// scroll carousel
  await tester.drag(
      find.byType(HorizontalBookCarouselView),
      const Offset(-200, 0),
  );
  await tester.pumpAndSettle(delayFiveSec);

  expect(find.byKey(const Key(TEST_BOOK_ONE)), findsOneWidget);

  /// tap on Library Button Nav Tab
  await tester.tap(find.text(LIBRARY_TEXT));
  await tester.pumpAndSettle(delayFiveSec);

  /// check if recently visited books are there
  expect(find.text(TEST_BOOK_ONE), findsOneWidget);
  expect(find.text(TEST_BOOK_TWO), findsOneWidget);
  expect(find.text(TEST_BOOK_THREE), findsOneWidget);

  return Future.value(null);
}
