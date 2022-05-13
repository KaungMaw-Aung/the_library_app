import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/home_bloc.dart';
import 'package:the_library_app/data/vos/book_overview_list_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/pages/more_books_page.dart';
import 'package:the_library_app/pages/search_page.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';
import 'package:the_library_app/view_items/carousel_item_view.dart';
import 'package:the_library_app/widgets/horizontal_audiobook_section_view.dart';
import 'package:the_library_app/widgets/horizontal_book_section_view.dart';
import 'package:the_library_app/widgets/search_play_books_app_bar_view.dart';

import 'add_to_shelf_page.dart';
import 'book_details_page.dart';

class HomePage extends StatelessWidget {
  var tabLabels = [EBOOKS_TAB_LABEL, AUDIOBOOKS_TAB_LABEL];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            child: Hero(
              tag: 'search',
              child: SearchPlayBooksAppBarView(
                onSearchBoxTap: () => _navigateToSearchPage(context),
              ),
            ),
            preferredSize: const Size.fromHeight(SEARCH_APP_BAR_HEIGHT),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: MARGIN_MEDIUM),
                Selector<HomeBloc, List<BookVO>?>(
                  selector: (context, bloc) => bloc.carouselBooks,
                  builder: (context, visitedBooks, child) {
                    return Visibility(
                      visible:
                          (visitedBooks != null && visitedBooks.isNotEmpty),
                      child: HorizontalBookCarouselView(
                        onTapCarouselItem: (bookTitle) =>
                            _navigateToBookDetails(context, bookTitle),
                        onOverflowTap: (book) =>
                            _showMoreOptionsOnCarouselBook(context, book),
                        visitedBooks:
                            (visitedBooks != null && visitedBooks.isNotEmpty)
                                ? visitedBooks
                                : [],
                      ),
                    );
                  },
                ),
                const SizedBox(height: MARGIN_MEDIUM_2),
                Builder(
                  builder: (context) {
                    return DefaultTabController(
                      length: tabLabels.length,
                      child: TabBar(
                        isScrollable: false,
                        indicatorWeight: MARGIN_SMALL,
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.grey,
                        labelPadding: const EdgeInsets.symmetric(
                          vertical: MARGIN_CARD_MEDIUM_2,
                        ),
                        indicatorSize: TabBarIndicatorSize.label,
                        onTap: (index) {
                          HomeBloc bloc = Provider.of(context, listen: false);
                          bloc.onTapTab(index);
                        },
                        tabs: tabLabels.map((label) {
                          return Text(label);
                        }).toList(),
                      ),
                    );
                  },
                ),
                Selector<HomeBloc, int>(
                  selector: (context, bloc) => bloc.selectedTabIndex,
                  builder: (context, selectedTabIndex, child) {
                    return Visibility(
                      visible: selectedTabIndex == 0,
                      child: Selector<HomeBloc, List<BookOverviewListVO>?>(
                        selector: (context, bloc) => bloc.bookOverviewLists,
                        builder: (context, bookOverviewLists, child) {
                          return EbooksSectionView(
                            onTitleTap: (listName, listNameEncoded) =>
                                _goToMoreBooksPage(
                              context,
                              listName,
                              listNameEncoded,
                            ),
                            onTapBook: (title) => _navigateToBookDetails(
                              context,
                              title,
                            ),
                            onTapOverflow: () =>
                                _showMoreOptionsOnBook(context),
                            bookOverviewLists: bookOverviewLists,
                          );
                        },
                      ),
                    );
                  },
                ),
                Selector<HomeBloc, int>(
                  selector: (context, bloc) => bloc.selectedTabIndex,
                  builder: (context, selectedTabIndex, child) {
                    return Visibility(
                      visible: selectedTabIndex == 1,
                      child: AudiobooksSectionView(
                        onTapBook: () => _navigateToBookDetails(context, ''),
                        onTitleTap: () => {},
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

  void _goToMoreBooksPage(
    BuildContext context,
    String listName,
    String listNameEncoded,
  ) {
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

  void _showMoreOptionsOnCarouselBook(BuildContext context, BookVO? book) {
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
                          image: DecorationImage(
                            image: NetworkImage(
                              book?.cover ??
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
                      children: [
                        Text(
                          book?.title ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: MARGIN_SMALL),
                        Text(
                          book?.author ?? "",
                          style: const TextStyle(
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
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddToShelfPage(book),
                    ),
                  );
                },
                leading: const Icon(Icons.add),
                title: const Text(
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

  void _navigateToBookDetails(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsPage(title: title),
      ),
    );
  }

  void _navigateToSearchPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(),
      ),
    );
  }
}

class AudiobooksSectionView extends StatelessWidget {
  final Function onTapBook;
  final Function onTitleTap;

  AudiobooksSectionView({
    required this.onTapBook,
    required this.onTitleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: MARGIN_MEDIUM),
        HorizontalAudiobookSectionView(
          audiobookListTitle: AUDIOBOOKS_FOR_YOU,
          onTapAudiobook: onTapBook,
          onAudiobookSectionTitleTap: onTitleTap,
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        HorizontalAudiobookSectionView(
          audiobookListTitle: FICTION_AND_LITERATURE,
          onTapAudiobook: onTapBook,
          onAudiobookSectionTitleTap: onTitleTap,
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        HorizontalAudiobookSectionView(
          audiobookListTitle: BUSINESS_AND_INVESTING,
          onTapAudiobook: onTapBook,
          onAudiobookSectionTitleTap: onTitleTap,
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        HorizontalAudiobookSectionView(
          audiobookListTitle: SELF_HELP,
          onTapAudiobook: onTapBook,
          onAudiobookSectionTitleTap: onTitleTap,
        ),
      ],
    );
  }
}

class EbooksSectionView extends StatelessWidget {
  final Function(String) onTapBook;
  final Function onTapOverflow;
  final Function(String, String) onTitleTap;
  final List<BookOverviewListVO>? bookOverviewLists;

  EbooksSectionView({
    required this.onTapBook,
    required this.onTapOverflow,
    required this.onTitleTap,
    required this.bookOverviewLists,
  });

  @override
  Widget build(BuildContext context) {
    return bookOverviewLists != null
        ? Column(
            children: bookOverviewLists
                    ?.map((bookOverviewList) => HorizontalBookSectionView(
                          bookListTitle: bookOverviewList.listName ?? "",
                          listNameEncoded:
                              bookOverviewList.listNameEncoded ?? "",
                          onTapBook: onTapBook,
                          onTapOverflow: onTapOverflow,
                          onTitleTap: onTitleTap,
                          books: bookOverviewList.books,
                        ))
                    .toList() ??
                [],
          )
        : Container(
            margin: const EdgeInsets.only(
              top: MARGIN_XXLARGE,
            ),
            child: const CircularProgressIndicator(),
          );
  }
}

class HorizontalBookCarouselView extends StatelessWidget {
  final List<BookVO> visitedBooks;
  final Function(String) onTapCarouselItem;
  final Function(BookVO?) onOverflowTap;

  HorizontalBookCarouselView({
    required this.onTapCarouselItem,
    required this.onOverflowTap,
    required this.visitedBooks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: BOOK_CAROUSEL_HEIGHT,
      child: CarouselSlider(
        options: CarouselOptions(
          height: BOOK_CAROUSEL_HEIGHT,
          aspectRatio: 1 / 1,
          viewportFraction: 0.6,
          initialPage: 0,
          enableInfiniteScroll: false,
          reverse: false,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: visitedBooks.map((visitedBook) {
          return CarouselItemView(
            onTapCarouselItem: onTapCarouselItem,
            onOverflowTap: onOverflowTap,
            visitedBook: visitedBook,
          );
        }).toList(),
      ),
    );
  }
}
