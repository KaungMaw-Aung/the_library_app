import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/blocs/book_details_bloc.dart';

import '../data/models/library_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {

  group("Book Details Bloc Test", () {

    BookDetailsBloc? bloc;

    setUp(() {
      bloc = BookDetailsBloc("Result Book Four", LibraryModelImplMock());
    });

    test("get book details by title from database test", () {
      expect(bloc?.book, getMockBooks().last);
    });

  });

}