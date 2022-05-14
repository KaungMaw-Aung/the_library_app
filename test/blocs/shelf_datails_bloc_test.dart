import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/blocs/shelf_details_bloc.dart';

import '../data/models/library_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {

  group("Shelf Details Bloc Test", () {

    ShelfDetailsBloc? bloc;

    setUp(() {
      bloc = ShelfDetailsBloc("0", LibraryModelImplMock());
    });

    test("get shelf detail stream test", () {
      expect(bloc?.shelf, getMockShelves().first);
      expect(bloc?.books, getMockBooks().reversed);
      expect(bloc?.chipsData, getMockChips());
    });

    test("on edit and confirm shelf test", () {
      /// on edit
      expect(bloc?.showShelfEditViews, false);
      bloc?.onTapEditShelf();
      expect(bloc?.showShelfEditViews, true);

      /// on done edit
      bloc?.doneEditShelf();
      expect(bloc?.showShelfEditViews, false);
    });

  });

}