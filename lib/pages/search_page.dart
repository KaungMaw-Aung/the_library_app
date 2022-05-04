import 'package:flutter/material.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/pages/search_detail_page.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';
import 'package:the_library_app/view_items/search_result_book_view.dart';
import 'package:the_library_app/widgets/search_bar_view.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<BookVO> dummyBooks = [
    BookVO(
      "https://i.pinimg.com/originals/ed/5f/51/ed5f51b122684dd72381f09c8fc39cbe.jpg",
      "Book One",
      "Author One",
      "Description",
      "0.0",
      "Publisher",
      1,
    ),
    BookVO(
      "https://www.theyoungfolks.com/wp-content/uploads/2017/08/six-of-crows-770x1156.jpg",
      "Book Two",
      "Author Two",
      "Description",
      "0.0",
      "Publisher",
      2,
    ),
    BookVO(
      "https://rivetedlit.com/wp-content/uploads/2020/01/all-this-time-9781534466340_xlg.jpg",
      "Book Three",
      "Author Three",
      "Description",
      "0.0",
      "Publisher",
      3,
    ),
    BookVO(
      "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/action-thriller-book-cover-design-template-3675ae3e3ac7ee095fc793ab61b812cc_screen.jpg?ts=1637008457",
      "Book Four",
      "Author Four",
      "Description",
      "0.0",
      "Publisher",
      4,
    ),
    BookVO(
      "https://marketplace.canva.com/EAD7WuSVrt0/1/0/1003w/canva-colorful-illustration-young-adult-book-cover-LVthABb24ik.jpg",
      "Book Five",
      "Author Five",
      "Description",
      "0.0",
      "Publisher",
      5,
    ),
    BookVO(
      "https://www.skipprichard.com/wp-content/uploads/2019/12/9780525645580.jpg",
      "Book Six",
      "Author Six",
      "Description",
      "0.0",
      "Publisher",
      6,
    ),
    BookVO(
      "https://img.buzzfeed.com/buzzfeed-static/static/2020-12/22/20/asset/d501ee3b6aaa/sub-buzz-8285-1608667292-7.jpg?downsize=700%3A%2A&output-quality=auto&output-format=auto",
      "Book Seven",
      "Author Seven",
      "Description",
      "0.0",
      "Publisher",
      7,
    ),
    BookVO(
      "http://bukovero.com/wp-content/uploads/2016/07/Harry_Potter_and_the_Cursed_Child_Special_Rehearsal_Edition_Book_Cover.jpg",
      "Book Eight",
      "Author Eight",
      "Description",
      "0.0",
      "Publisher",
      8,
    ),
    BookVO(
      "https://edit.org/photos/images/cat/book-covers-big-2019101610.jpg-1300.jpg",
      "Book Nine",
      "Author Nine",
      "Description",
      "0.0",
      "Publisher",
      9,
    ),
  ];

  /// State Variables
  List<BookVO> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'search',
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: MARGIN_MEDIUM_2),
              SearchBarView(
                onSearchTextChanged: (input) {
                  setState(() {
                    searchResults = input.isNotEmpty
                        ? dummyBooks.where((element) {
                            return element.title?.contains(input) ?? false;
                          }).toList()
                        : [];
                  });
                },
                onSubmit: (searchedText) {
                  if (searchedText.isNotEmpty) {
                    _goToSearchDetailPage(
                      context,
                      searchedText,
                    );
                  }
                },
              ),
              const Divider(
                color: Colors.black54,
                height: MARGIN_LARGE,
              ),
              Visibility(
                visible: searchResults.isEmpty,
                child: const TopSellingNewReleasesAndBookStoreView(),
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: searchResults
                      .map(
                        (book) => SearchResultBookView(
                          cover: book.cover ?? "",
                          title: book.title ?? "",
                          author: book.author ?? "",
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToSearchDetailPage(BuildContext context, String searchedText) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchDetailPage(
          searchedText: searchedText,
        ),
      ),
    );
  }
}

class TopSellingNewReleasesAndBookStoreView extends StatelessWidget {
  const TopSellingNewReleasesAndBookStoreView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: const ListTile(
            leading: Icon(
              Icons.trending_up_outlined,
              color: Colors.blue,
            ),
            title: Text(
              TOP_SELLING,
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: const ListTile(
            leading: Icon(
              Icons.new_releases_outlined,
              color: Colors.blue,
            ),
            title: Text(
              NEW_RELEASES,
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: const ListTile(
            leading: Icon(
              Icons.store_outlined,
              color: Colors.blue,
            ),
            title: Text(
              BOOKSTORE,
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
