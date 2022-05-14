import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/blocs/search_detail_bloc.dart';
import 'package:the_library_app/data/vos/book_overview_list_vo.dart';

import '../data/models/library_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Search Detail Bloc Test", () {
    SearchDetailBloc? bloc;

    setUp(() {
      bloc = SearchDetailBloc("", LibraryModelImplMock());
    });

    test("search and get books result test", () {
      expect(
        bloc?.resultOverviewBookLists,
        [
          BookOverviewListVO("Comedy", "Comedy", [getMockBooks().first]),
          BookOverviewListVO("Education", "Education", [getMockBooks()[1]]),
          BookOverviewListVO("Sciences", "Sciences", [getMockBooks()[2]]),
          BookOverviewListVO("Musical", "Musical", [getMockBooks().last]),
        ],
      );
    });
  });
}
