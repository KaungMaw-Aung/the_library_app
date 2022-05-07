import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/models/library_model_impl.dart';
import 'package:the_library_app/data/vos/book_overview_list_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';

class SearchDetailBloc extends ChangeNotifier {
  /// State Variables
  List<BookOverviewListVO>? resultOverviewBookLists;

  /// Model
  final LibraryModel _libraryModel = LibraryModelImpl();

  SearchDetailBloc(String searchedText) {
    _libraryModel.searchAndGetBooksResult(searchedText).then((result) {
      resultOverviewBookLists = result
          ?.groupListsBy((book) => book.category ?? searchedText)
          .map<String, BookOverviewListVO>(
            (key, value) => MapEntry(
              key,
              BookOverviewListVO(key, key, value),
            ),
          ).values.toList();
      notifyListeners();
    }).catchError((error) => debugPrint(error.toString()));
  }
}
