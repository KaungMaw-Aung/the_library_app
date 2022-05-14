import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/blocs/search_bloc.dart';

import '../data/models/library_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {

  group("Search Bloc Test", () {

    SearchBloc? bloc;

    setUp(() {
      bloc = SearchBloc(LibraryModelImplMock());
    });

    test("on search test", () async {
      bloc?.onSearch("test");
      await Future.delayed(const Duration(seconds: 3));
      expect(bloc?.resultBooks, getMockBooks());
    });

    test("on search with empty query test", () async {
      bloc?.onSearch("test");
      await Future.delayed(const Duration(seconds: 3));
      expect(bloc?.resultBooks, getMockBooks());

      bloc?.onSearchWithEmptyQuery();
      expect(bloc?.resultBooks?.isEmpty, true);
    });

  });

}