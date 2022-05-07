import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/more_books_bloc.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';
import 'package:the_library_app/view_items/book_grid_item_view.dart';
import 'package:the_library_app/widgets/smart_vertical_two_columns_grid_view.dart';

import 'book_details_page.dart';

class MoreBooksPage extends StatelessWidget {
  final String listName;
  final String listNameEncoded;

  MoreBooksPage({
    required this.listName,
    required this.listNameEncoded,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MoreBookBloc(listNameEncoded),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: MARGIN_MEDIUM_2,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: MARGIN_MEDIUM_2),
                    const Icon(Icons.arrow_back),
                    const SizedBox(width: MARGIN_LARGE),
                    Expanded(
                      child: Text(
                        listName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: MARGIN_MEDIUM_3,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black54,
                height: 0,
              ),
              Selector<MoreBookBloc, List<BookVO>?>(
                selector: (context, bloc) => bloc.books,
                shouldRebuild: (oldValue, newValue) => oldValue != newValue,
                builder: (context, books, child) {
                  return books != null
                      ? Expanded(
                        child: SmartVerticalTwoColumnsGridView(
                            itemCount: books.length,
                            itemBuilder: (context, index) {
                              return BookGridItemView(
                                book: books[index],
                                gridCount: 2,
                                onBookTap: (title) => _navigateToBookDetails(
                                  context,
                                  title,
                                ),
                                onOverflowTap: () =>
                                    _showMoreOptionsOnBook(context),
                              );
                            },
                            padding:
                                const EdgeInsets.only(top: MARGIN_MEDIUM_2),
                            onListEndReached: () {
                              MoreBookBloc bloc = Provider.of(context, listen: false);
                              bloc.onListEndReached();
                            },
                          ),
                      )
                      : Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.4),
                          child: const CircularProgressIndicator(),
                        );
                },
              )
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

  void _navigateToBookDetails(BuildContext context, String bookTitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsPage(title: bookTitle),
      ),
    );
  }
}
