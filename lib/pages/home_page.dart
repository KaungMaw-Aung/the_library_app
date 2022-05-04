import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_library_app/pages/more_books_page.dart';
import 'package:the_library_app/pages/search_page.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';
import 'package:the_library_app/view_items/carousel_item_view.dart';
import 'package:the_library_app/widgets/horizontal_audiobook_section_view.dart';
import 'package:the_library_app/widgets/horizontal_book_section_view.dart';
import 'package:the_library_app/widgets/search_play_books_app_bar_view.dart';

import 'book_details_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var tabLabels = [EBOOKS_TAB_LABEL, AUDIOBOOKS_TAB_LABEL];

  var selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              HorizontalBookCarouselView(
                onTapCarouselItem: () => _navigateToBookDetails(context),
                onOverflowTap: () => _showMoreOptionsOnBook(context),
              ),
              const SizedBox(height: MARGIN_MEDIUM_2),
              DefaultTabController(
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
                    setState(() {
                      selectedTabIndex = index;
                    });
                  },
                  tabs: tabLabels.map((label) {
                    return Text(label);
                  }).toList(),
                ),
              ),
              Visibility(
                visible: selectedTabIndex == 0,
                child: EbooksSectionView(
                  onTitleTap: () => _goToMoreBooksPage(context),
                  onTapBook: () => _navigateToBookDetails(context),
                  onTapOverflow: () => _showMoreOptionsOnBook(context),
                ),
              ),
              Visibility(
                visible: selectedTabIndex == 1,
                child: AudiobooksSectionView(
                  onTapBook: () => _navigateToBookDetails(context),
                  onTitleTap: () => _goToMoreBooksPage(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToMoreBooksPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoreBooksPage(),
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
        builder: (context) => const BookDetailsPage(),
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
  final Function onTapBook;
  final Function onTapOverflow;
  final Function onTitleTap;

  EbooksSectionView({
    required this.onTapBook,
    required this.onTapOverflow,
    required this.onTitleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: MARGIN_MEDIUM),
        HorizontalBookSectionView(
          bookListTitle: EBOOKS_FOR_YOU,
          onTapBook: onTapBook,
          onTapOverflow: onTapOverflow,
          onTitleTap: onTitleTap,
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        HorizontalBookSectionView(
          bookListTitle: ON_YOUR_WISHLIST,
          onTapBook: onTapBook,
          onTapOverflow: onTapOverflow,
          onTitleTap: onTitleTap,
        ),
      ],
    );
  }
}

class HorizontalBookCarouselView extends StatelessWidget {
  final Function onTapCarouselItem;
  final Function onOverflowTap;

  HorizontalBookCarouselView({
    required this.onTapCarouselItem,
    required this.onOverflowTap,
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
        items: [
          CarouselItemView(
            onTapCarouselItem: onTapCarouselItem,
            onOverflowTap: onOverflowTap,
          ),
          CarouselItemView(
            onTapCarouselItem: onTapCarouselItem,
            onOverflowTap: onOverflowTap,
          ),
          CarouselItemView(
            onTapCarouselItem: onTapCarouselItem,
            onOverflowTap: onOverflowTap,
          ),
        ],
      ),
    );
  }
}
