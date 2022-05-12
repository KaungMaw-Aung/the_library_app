import 'package:flutter/foundation.dart';
import 'package:the_library_app/data/models/library_model.dart';
import 'package:the_library_app/data/models/library_model_impl.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:uuid/uuid.dart';

class CreateNewShelfBloc extends ChangeNotifier {
  /// Model
  final LibraryModel _libraryModel = LibraryModelImpl();

  void createNewShelf(String shelfName) {
    var uuid = const Uuid();
    _libraryModel.createShelf(
      ShelfVO(
        uuid.v4(),
        shelfName,
        DateTime.now(),
      ),
    );
  }
}
