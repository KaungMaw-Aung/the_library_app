import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/blocs/more_books_bloc.dart';

import '../data/models/library_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("More Books Bloc Test", () {
    MoreBookBloc? bloc;

    setUp(() {
      bloc = MoreBookBloc("", LibraryModelImplMock());
    });

    test("get more on overview list test", () {
      expect(bloc?.offset, 0);
      expect(bloc?.books, getMockBookOverviewLists().first.books);
    });

    test("on list end reached test", () async {
      bloc?.onListEndReached();
      await Future.delayed(const Duration(seconds: 3));
      expect(bloc?.offset, 20);
      expect(
        bloc?.books,
        [
          ...?getMockBookOverviewLists().first.books,
          ...?getMockBookOverviewLists().first.books,
        ],
      );
    });
  });
}
