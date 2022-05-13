import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/search_bloc.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/pages/search_detail_page.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';
import 'package:the_library_app/util/debouncer.dart';
import 'package:the_library_app/view_items/search_result_book_view.dart';
import 'package:the_library_app/widgets/search_bar_view.dart';

import 'book_details_page.dart';

class SearchPage extends StatelessWidget {

 final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchBloc(),
      child: Hero(
        tag: 'search',
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: MARGIN_MEDIUM_2),
                Builder(
                  builder: (context) {
                    return SearchBarView(
                      onSearchTextChanged: (query) {
                        _debouncer.run(() {
                          SearchBloc bloc = Provider.of(context, listen: false);
                          if (query.isNotEmpty) {
                            bloc.onSearch(query);
                          } else {
                            bloc.onSearchWithEmptyQuery();
                          }
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
                      onTapBack: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                const Divider(
                  color: Colors.black54,
                  height: MARGIN_LARGE,
                ),
                Selector<SearchBloc, List<BookVO>?>(
                  selector: (context, bloc) => bloc.resultBooks,
                  builder: (context, searchResults, child) {
                    return Visibility(
                      visible: searchResults?.isEmpty ?? false,
                      child: const TopSellingNewReleasesAndBookStoreView(),
                    );
                  },
                ),
                Selector<SearchBloc, List<BookVO>?>(
                  selector: (context, bloc) => bloc.resultBooks,
                  shouldRebuild: (oldValue, newValue) => oldValue != newValue,
                  builder: (context, searchResults, child) {
                    return Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: searchResults
                                ?.map(
                                  (book) => SearchResultBookView(
                                    cover: book.cover ?? "",
                                    title: book.title ?? "",
                                    author: book.author ?? "",
                                    onTapResult: (bookTitle) {
                                      _navigateToBookDetails(
                                        context,
                                        bookTitle,
                                      );
                                    },
                                  ),
                                ).toList() ?? [],
                      ),
                    );
                  },
                ),
              ],
            ),
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

  void _navigateToBookDetails(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsPage(title: title),
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
