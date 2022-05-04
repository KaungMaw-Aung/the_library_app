import 'package:flutter/material.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';
import 'package:the_library_app/view_items/book_grid_item_view.dart';

import 'book_details_page.dart';

class MoreBooksPage extends StatelessWidget {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: MARGIN_MEDIUM_2,
                ),
                child: Row(
                  children: const [
                    SizedBox(width: MARGIN_MEDIUM_2),
                    Icon(Icons.arrow_back),
                    SizedBox(width: MARGIN_LARGE),
                    Text(
                      "Book Section Title",
                      style: TextStyle(
                        fontSize: MARGIN_MEDIUM_3,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black54,
                height: 0,
              ),
              GridView.builder(
                padding: const EdgeInsets.only(top: MARGIN_MEDIUM_2),
                itemCount: dummyBooks.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.8,
                ),
                itemBuilder: (context, index) {
                  return BookGridItemView(
                    book: dummyBooks[index],
                    gridCount: 2,
                    onBookTap: () => _navigateToBookDetails(context),
                    onOverflowTap: () => _showMoreOptionsOnBook(context),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMoreOptionsOnBook(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Wrap(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: MARGIN_MEDIUM_2),
                    Card(
                      elevation: MARGIN_SMALL,
                      margin: EdgeInsets.zero,
                      child: Container(
                        width: BOOK_LIST_ITEM_COVER_WIDTH,
                        height: BOOK_LIST_ITEM_HEIGHT,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(MARGIN_SMALL),
                          image: const DecorationImage(
                            image: NetworkImage(
                              "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/action-thriller-book-cover-design-template-3675ae3e3ac7ee095fc793ab61b812cc_screen.jpg?ts=1637008457",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: MARGIN_MEDIUM_2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Book Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: MARGIN_SMALL),
                        Text(
                          "Author Name",
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Divider(
                color: Colors.black54,
                height: 0.0,
              ),
              const ListTile(
                leading: Icon(Icons.remove_circle_outline_rounded),
                title: Text(
                  REMOVE_DOWNLOAD,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  DELETE_FROM_LIBRARY,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.add),
                title: Text(
                  ADD_TO_SHELF,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.book_rounded),
                title: Text(
                  ABOUT_THIS_EBOOK,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: MARGIN_SMALL,
                  left: MARGIN_MEDIUM_2,
                  right: MARGIN_MEDIUM_2,
                  bottom: MARGIN_MEDIUM_2,
                ),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Buy \$4.99"),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  void _navigateToBookDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsPage(title: ''),
      ),
    );
  }

}
