import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_library_app/data/vos/book_vo.dart';

import 'package:the_library_app/pages/host_page.dart';
import 'package:the_library_app/persistence/persistence_constants.dart';
import 'package:collection/collection.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(BookVOAdapter());

  await Hive.openBox<BookVO>(BOX_NAME_BOOK_VO);
  await Hive.openBox<BookVO>(BOX_NAME_VISITED_BOOK_VO);

  runApp(const LibraryApp());
}

class Animal {
  String name;
  List<String> type;

  Animal(this.name, this.type);
}

class LibraryApp extends StatelessWidget {
  const LibraryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HostPage(),
    );
  }
}

