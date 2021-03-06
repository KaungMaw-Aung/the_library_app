import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/search_detail_bloc.dart';
import 'package:the_library_app/data/vos/book_overview_list_vo.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';
import 'package:the_library_app/widgets/horizontal_book_section_view.dart';
import 'package:the_library_app/widgets/search_bar_view.dart';

import 'book_details_page.dart';
import 'more_books_page.dart';

class SearchDetailPage extends StatelessWidget {
  final String searchedText;

  SearchDetailPage({required this.searchedText});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchDetailBloc(searchedText),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: MARGIN_MEDIUM_2),
                SearchBarView(
                  onSearchTextChanged: (input) {},
                  onSubmit: (searchedText) {},
                  autoFocus: false,
                  enabled: false,
                  preLoadText: searchedText,
                  onTapBack: () {
                    Navigator.pop(context);
                  },
                ),
                const Divider(
                  color: Colors.black54,
                  height: MARGIN_LARGE,
                ),
                Selector<SearchDetailBloc, List<BookOverviewListVO>?>(
                  builder: (context, resultOverviewBookLists, child) {
                    return Column(
                      children: resultOverviewBookLists?.map((overviewList) {
                            return HorizontalBookSectionView(
                              bookListTitle: overviewList.listName ?? "",
                              listNameEncoded:
                                  overviewList.listNameEncoded ?? "",
                              onTapBook: (title) => _navigateToBookDetails(
                                context,
                                title,
                              ),
                              onTapOverflow: () =>
                                  _showMoreOptionsOnBook(context),
                              onTitleTap: (listName, listNameEncoded) {
                                _goToMoreBooksPage(
                                  context,
                                  listName,
                                  listNameEncoded,
                                );
                              },
                              books: overviewList.books,
                            );
                          }).toList() ??
                          [],
                    );
                  },
                  selector: (context, bloc) => bloc.resultOverviewBookLists,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goToMoreBooksPage(BuildContext context, String listName, String listNameEncoded) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoreBooksPage(
          listNameEncoded: listNameEncoded,
          listName: listName,
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
