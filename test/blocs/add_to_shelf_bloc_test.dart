import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/blocs/add_to_shelf_bloc.dart';

import '../data/models/library_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {

  group("Add To Shelf Bloc Test", () {

    AddToShelfBloc? bloc;

    setUp(() {
      bloc = AddToShelfBloc(LibraryModelImplMock());
    });

    test("get shelves test", () {
      expect(bloc?.shelves, getMockShelves());
    });

  });

}