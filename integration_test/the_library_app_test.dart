import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/main.dart';
import 'package:the_library_app/persistence/persistence_constants.dart';

import 'add_book_to_library_flow_test.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(BookVOAdapter());
  Hive.registerAdapter(ShelfVOAdapter());

  await Hive.openBox<BookVO>(BOX_NAME_BOOK_VO);
  await Hive.openBox<BookVO>(BOX_NAME_VISITED_BOOK_VO);
  await Hive.openBox<ShelfVO>(BOX_NAME_SHELF_VO);

  testWidgets(
    "Test Add to Library, Search, Operations in Library and Operations in Shelf",
    (WidgetTester tester) async {

      var delayFiveSec = const Duration(seconds: 5);

      await tester.pumpWidget(const LibraryApp());
      await Future.delayed(const Duration(seconds: 2));

      await tester.pumpAndSettle(delayFiveSec);

      await testAddBookToLibrary(tester);

    },
  );
}
