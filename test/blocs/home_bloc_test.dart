import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/blocs/home_bloc.dart';

import '../data/models/library_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Home Bloc Test", () {
    HomeBloc? bloc;

    setUp(() {
      bloc = HomeBloc(LibraryModelImplMock());
    });

    test("get book overview lists test", () {
      expect(
        bloc?.bookOverviewLists,
        getMockBookOverviewLists(),
      );
    });

    test("get all visited books test", () {
      expect(
        bloc?.carouselBooks,
        getMockBooks(),
      );
    });

    test("on tap tab test", () {
      /// start with index 0
      expect(bloc?.selectedTabIndex, 0);
      bloc?.onTapTab(1);
      expect(bloc?.selectedTabIndex, 1);
    });

  });
}
