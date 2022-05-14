import 'package:the_library_app/data/vos/book_overview_list_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';

List<BookOverviewListVO> getMockBookOverviewLists() {
  return [
    BookOverviewListVO(
      "Comedy",
      "comedy",
      [
        BookVO(
          "https://www.theyoungfolks.com/wp-content/uploads/2017/08/six-of-crows-770x1156.jpg",
          "Comedy Book One",
          "Comedy Author One",
          "This is comedy book one.",
          "1.0",
          "Comedy Book One Publisher",
          null,
          "Comedy",
        ),
        BookVO(
          "https://www.theyoungfolks.com/wp-content/uploads/2017/08/six-of-crows-770x1156.jpg",
          "Comedy Book Two",
          "Comedy Author Two",
          "This is comedy book two.",
          "2.0",
          "Comedy Book Two Publisher",
          null,
          "Comedy",
        ),
      ],
    ),
    BookOverviewListVO(
      "Sciences",
      "sciences",
      [
        BookVO(
          "sciences_book_one_cover.jpg",
          "Sciences Book One",
          "Sciences Author One",
          "This is sciences book one.",
          "1.0",
          "Sciences Book One Publisher",
          null,
          "Sciences",
        ),
        BookVO(
          "sciences_book_two_cover.jpg",
          "Sciences Book Two",
          "Sciences Author Two",
          "This is sciences book two.",
          "2.0",
          "Sciences Book Two Publisher",
          null,
          "Sciences",
        ),
      ],
    ),
  ];
}

List<BookVO> getMockBooks() {
  return [
    BookVO(
      "result_book_one_cover.jpg",
      "Result Book One",
      "Result Author One",
      "This is result book one.",
      "1.0",
      "Result Book One Publisher",
      null,
      "Comedy",
    ),
    BookVO(
      "result_book_two_cover.jpg",
      "Result Book Two",
      "Result Author Two",
      "This is result book two.",
      "2.0",
      "Result Book Two Publisher",
      null,
      "Education",
    ),
    BookVO(
      "result_book_three_cover.jpg",
      "Result Book Three",
      "Result Author Three",
      "This is result book three.",
      "3.0",
      "Result Book Three Publisher",
      null,
      "Sciences",
    ),
    BookVO(
      "result_book_four_cover.jpg",
      "Result Book Four",
      "Result Author Four",
      "This is result book four.",
      "2.0",
      "Result Book Four Publisher",
      null,
      "Musical",
    ),
  ];
}

List<ShelfVO> getMockShelves() {
  return [
    ShelfVO("0", "First Shelf", getMockBooks(), DateTime.now()),
    ShelfVO("1", "Second Shelf", [], DateTime.now()),
  ];
}
