import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/pages/library_page.dart';
import 'package:the_library_app/pages/search_detail_page.dart';
import 'package:the_library_app/pages/search_page.dart';

import 'test_data/test_data.dart';

Future<void> testSearchingBooks(WidgetTester tester) async {
  var delayFiveSec = const Duration(seconds: 5);

  /// tap search bar
  await tester.tap(find.text(SEARCH_PLAY_BOOKS));
  await tester.pumpAndSettle(delayFiveSec);

  /// check if search page appeared
  expect(find.byType(SearchPage), findsOneWidget);

  /// type query 'flutter'
  tester.testTextInput.enterText(SEARCH_QUERY);
  await tester.pumpAndSettle(delayFiveSec);

  /// check if suggestions appeared
  expect(find.text(SEARCH_RESULT_ONE), findsOneWidget);
  expect(find.text(SEARCH_RESULT_TWO), findsOneWidget);
  expect(find.text(SEARCH_RESULT_THREE), findsOneWidget);

  /// hit enter key on keyboard
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle(delayFiveSec);

  /// check search result detail page appeared
  expect(find.byType(SearchDetailPage), findsOneWidget);

  /// check result titles
  expect(find.text(SEARCH_RESULT_LIST_TITLE_ONE), findsOneWidget);
  expect(find.text(SEARCH_RESULT_LIST_TITLE_TWO), findsOneWidget);
  expect(find.text(SEARCH_RESULT_LIST_TITLE_THREE), findsNWidgets(2));
  expect(find.text(SEARCH_RESULT_ONE), findsOneWidget);
  expect(find.text(SEARCH_RESULT_TWO), findsOneWidget);
  expect(find.text(SEARCH_RESULT_FOUR), findsOneWidget);

  /// tap back
  await tester.tap(find.byKey(const Key(BACK_BTN_KEY)));
  await tester.pumpAndSettle(delayFiveSec);

  /// check if search page appeared
  expect(find.byType(SearchPage), findsOneWidget);

  /// tap back
  await tester.tap(find.byKey(const Key(BACK_BTN_KEY)));
  await tester.pumpAndSettle(delayFiveSec);

  /// check if library page appeared
  expect(find.byType(LibraryPage), findsOneWidget);

  return Future.value(null);
}