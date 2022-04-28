import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          child: SearchPlayBooksAppBarView(),
          preferredSize: const Size.fromHeight(SEARCH_APP_BAR_HEIGHT),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: MARGIN_MEDIUM),
              HorizontalBookCarouselView(
                onTapCarouselItem: () => _navigateToBookDetails(context),
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
                child: Column(
                  children: [
                    const SizedBox(height: MARGIN_MEDIUM),
                    HorizontalBookSectionView(
                      bookListTitle: EBOOKS_FOR_YOU,
                      onTapBook: () => _navigateToBookDetails(context),
                    ),
                    const SizedBox(height: MARGIN_MEDIUM),
                    HorizontalBookSectionView(
                      bookListTitle: ON_YOUR_WISHLIST,
                      onTapBook: () => _navigateToBookDetails(context),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: selectedTabIndex == 1,
                child: Column(
                  children: [
                    const SizedBox(height: MARGIN_MEDIUM),
                    HorizontalAudiobookSectionView(
                      audiobookListTitle: AUDIOBOOKS_FOR_YOU,
                      onTapAudiobook: () => _navigateToBookDetails(context),
                    ),
                    const SizedBox(height: MARGIN_MEDIUM),
                    HorizontalAudiobookSectionView(
                      audiobookListTitle: FICTION_AND_LITERATURE,
                      onTapAudiobook: () => _navigateToBookDetails(context),
                    ),
                    const SizedBox(height: MARGIN_MEDIUM),
                    HorizontalAudiobookSectionView(
                      audiobookListTitle: BUSINESS_AND_INVESTING,
                      onTapAudiobook: () => _navigateToBookDetails(context),
                    ),
                    const SizedBox(height: MARGIN_MEDIUM),
                    HorizontalAudiobookSectionView(
                      audiobookListTitle: SELF_HELP,
                      onTapAudiobook: () => _navigateToBookDetails(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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

}

class HorizontalBookCarouselView extends StatelessWidget {
  final Function onTapCarouselItem;

  HorizontalBookCarouselView({required this.onTapCarouselItem});

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
          ),
          CarouselItemView(
            onTapCarouselItem: onTapCarouselItem,
          ),
          CarouselItemView(
            onTapCarouselItem: onTapCarouselItem,
          ),
        ],
      ),
    );
  }
}
