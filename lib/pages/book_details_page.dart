import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/book_details_bloc.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';
import 'package:the_library_app/view_items/related_book_item_view.dart';
import 'package:the_library_app/widgets/book_list_title_and_more_button_view.dart';

class BookDetailsPage extends StatelessWidget {
  final String title;

  BookDetailsPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookDetailsBloc(title),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          actions: const [
            Icon(
              Icons.search,
              color: Colors.black,
            ),
            SizedBox(width: MARGIN_MEDIUM_2),
            Icon(
              Icons.bookmark_add_outlined,
              color: Colors.black,
            ),
            SizedBox(width: MARGIN_MEDIUM_2),
            Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            SizedBox(width: MARGIN_MEDIUM),
          ],
        ),
        body: Selector<BookDetailsBloc, BookVO?>(
          selector: (context, bloc) => bloc.book,
          builder: (context, book, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: MARGIN_LARGE),
                  BookCoverAndInfoView(book: book),
                  const SizedBox(height: MARGIN_LARGE),
                  const BookReviewsTypeAndPagesView(),
                  const SizedBox(height: MARGIN_MEDIUM_2),
                  FreeSampleAndBuyButtonsView(price: book?.price),
                  const SizedBox(height: MARGIN_MEDIUM),
                  const Divider(
                    height: MARGIN_MEDIUM_2,
                    thickness: 2.0,
                    color: Colors.black12,
                    indent: MARGIN_MEDIUM_3,
                    endIndent: MARGIN_MEDIUM_3,
                  ),
                  const SizedBox(height: MARGIN_MEDIUM_2),
                  BuildASeriesBundleSectionView(cover: book?.cover),
                  const SizedBox(height: MARGIN_MEDIUM_2),
                  AboutThisEbookSectionView(description: book?.description),
                  const SizedBox(height: MARGIN_MEDIUM_2),
                  const RatingsAndReviewsSectionView(),
                  RelatedBooksSectionView(
                    title: CONTINUE_THE_SERIES,
                  ),
                  RelatedBooksSectionView(
                    title: SIMILAR_EBOOKS,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    child: GiveRatingAndGooglePolicySectionView(),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class GiveRatingAndGooglePolicySectionView extends StatelessWidget {
  const GiveRatingAndGooglePolicySectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          RATE_THIS_EBOOK,
          style: TextStyle(
            fontSize: TEXT_CARD_REGULAR_2X,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        const Text(
          TELL_OTHER_WHAT_YOU_THINK,
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        Center(
          child: RatingBar.builder(
            initialRating: 0.0,
            unratedColor: Colors.black12,
            itemSize: MARGIN_XXLARGE,
            itemBuilder: (context, index) {
              return const Icon(
                Icons.star,
                color: Colors.blue,
              );
            },
            onRatingUpdate: (rating) {
              print("Rating updated: $rating");
            },
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        Center(
          child: OutlinedButton(
            onPressed: () {},
            child: const Text(WRITE_A_REVIEW),
          ),
        ),
        const Divider(
          height: MARGIN_XLARGE,
          thickness: 1.5,
          color: Colors.black12,
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        Row(
          children: const [
            Icon(Icons.replay_circle_filled_rounded),
            SizedBox(width: MARGIN_MEDIUM_2),
            Text(
              "Google Play refund policy",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        Row(
          children: const [
            Icon(Icons.info_outline_rounded),
            SizedBox(width: MARGIN_MEDIUM_2),
            Text(
              "All prices include GST.",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: MARGIN_XXLARGE),
      ],
    );
  }
}

class RelatedBooksSectionView extends StatelessWidget {
  final String title;

  RelatedBooksSectionView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => print("Tapped"),
          child: BookListTitleAndMoreButtonView(
            bookListTitle: title,
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        Container(
          height: HORIZONTAL_RELATED_BOOK_LIST_HEIGHT,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
            children: const [
              RelatedBookItemView(),
              RelatedBookItemView(),
              RelatedBookItemView(),
              RelatedBookItemView(),
            ],
          ),
        ),
      ],
    );
  }
}

class RatingsAndReviewsSectionView extends StatelessWidget {
  const RatingsAndReviewsSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => print("Tapped"),
          child: BookListTitleAndMoreButtonView(
            bookListTitle: RATINGS_AND_REVIEWS,
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        const RatingsView(),
        const ReviewsView(),
      ],
    );
  }
}

class ReviewsView extends StatelessWidget {
  const ReviewsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: MARGIN_LARGE),
        ReviewView(),
        SizedBox(height: MARGIN_LARGE),
        ReviewView(),
        SizedBox(height: MARGIN_LARGE),
        ReviewView(),
      ],
    );
  }
}

class ReviewView extends StatelessWidget {
  const ReviewView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: MARGIN_MEDIUM_2),
        const CircleAvatar(
          backgroundImage: NetworkImage(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzfG4grVjejPN1T_WwTFu0ig24GINUAjokZA&usqp=CAU",
          ),
          radius: REVIEW_USER_PROFILE_RADIUS,
        ),
        const SizedBox(width: MARGIN_MEDIUM_2),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Rachel Bethune",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: MARGIN_SMALL),
              RatingBarAndReviewDateView(),
              SizedBox(height: MARGIN_MEDIUM),
              Text(
                "The series is definitely picking up and all the characters are amazing in their own way.",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                ),
              ),
              SizedBox(height: MARGIN_MEDIUM_2),
              ReviewFeedbackView(),
            ],
          ),
        )
      ],
    );
  }
}

class ReviewFeedbackView extends StatelessWidget {
  const ReviewFeedbackView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          WAS_THIS_REVIEW_HELPFUL,
          style: TextStyle(
            fontSize: TEXT_SMALL_2,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: REVIEW_ROUNDED_OUTLINED_BUTTON_WIDTH,
          child: OutlinedButton(
            onPressed: () {},
            child: const Text(
              YES,
              style: TextStyle(color: Colors.black),
            ),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  MARGIN_XXLARGE,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: MARGIN_MEDIUM),
        SizedBox(
          width: REVIEW_ROUNDED_OUTLINED_BUTTON_WIDTH,
          child: OutlinedButton(
            onPressed: () {},
            child: const Text(
              NO,
              style: TextStyle(color: Colors.black),
            ),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  MARGIN_XXLARGE,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RatingBarAndReviewDateView extends StatelessWidget {
  const RatingBarAndReviewDateView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBar.builder(
          initialRating: 5.0,
          itemSize: MARGIN_MEDIUM_2,
          itemBuilder: (context, index) {
            return const Icon(
              Icons.star,
              color: Colors.blue,
            );
          },
          ignoreGestures: true,
          onRatingUpdate: (rating) {
            print("Rating updated: $rating");
          },
        ),
        const SizedBox(width: MARGIN_MEDIUM),
        const Text(
          "Feb 9, 2021",
          style: TextStyle(fontSize: TEXT_SMALL_2),
        ),
      ],
    );
  }
}

class RatingsView extends StatelessWidget {
  const RatingsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: MARGIN_MEDIUM_2),
        const RatingCountView(),
        const SizedBox(width: MARGIN_MEDIUM_2),
        Column(
          children: [
            HorizontalRatingPeopleCountView(
              value: 0.9,
              ratingValue: '5',
            ),
            const SizedBox(height: MARGIN_SMALL),
            HorizontalRatingPeopleCountView(
              value: 0.1,
              ratingValue: '4',
            ),
            const SizedBox(height: MARGIN_SMALL),
            HorizontalRatingPeopleCountView(
              value: 0.0,
              ratingValue: '3',
            ),
            const SizedBox(height: MARGIN_SMALL),
            HorizontalRatingPeopleCountView(
              value: 0.0,
              ratingValue: '2',
            ),
            const SizedBox(height: MARGIN_SMALL),
            HorizontalRatingPeopleCountView(
              value: 0.05,
              ratingValue: '1',
            ),
          ],
        )
      ],
    );
  }
}

class HorizontalRatingPeopleCountView extends StatelessWidget {
  final String ratingValue;
  final double value;

  HorizontalRatingPeopleCountView({
    required this.ratingValue,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(ratingValue),
        const SizedBox(width: MARGIN_MEDIUM),
        SizedBox(
          width: RATING_HORIZONTAL_BAR_WIDTH,
          height: RATING_HORIZONTAL_BAR_HEIGHT,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(MARGIN_MEDIUM)),
              ),
              Container(
                width: RATING_HORIZONTAL_BAR_WIDTH * value,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(MARGIN_MEDIUM)),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class RatingCountView extends StatelessWidget {
  const RatingCountView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "4.9",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: RATING_TEXT_SIZE,
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        RatingBar.builder(
          initialRating: 5.0,
          itemSize: MARGIN_MEDIUM_2,
          itemBuilder: (context, index) {
            return const Icon(
              Icons.star,
              color: Colors.blue,
            );
          },
          ignoreGestures: true,
          onRatingUpdate: (rating) {
            print("Rating updated: $rating");
          },
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        Text("86 total"),
      ],
    );
  }
}

class AboutThisEbookSectionView extends StatelessWidget {
  final String? description;

  AboutThisEbookSectionView({required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => print("Tapped"),
          child: BookListTitleAndMoreButtonView(
            bookListTitle: ABOUT_THIS_EBOOK,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: Text(
            description ?? "",
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class BuildASeriesBundleSectionView extends StatelessWidget {
  final String? cover;

  BuildASeriesBundleSectionView({required this.cover});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: Text(
            BUILD_A_SERIES_BUNDLE,
            style: TextStyle(
                fontSize: TEXT_CARD_REGULAR_2X, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: MARGIN_MEDIUM_2),
            SeriesBundleBooksCountView(cover: cover),
            const SizedBox(width: MARGIN_MEDIUM_2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "7 volumes available",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: MARGIN_MEDIUM),
                Text(
                  SELECT_ANY_COMBINATION,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                )
              ],
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.22,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text("Build"),
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}

class SeriesBundleBooksCountView extends StatelessWidget {
  final String? cover;

  SeriesBundleBooksCountView({required this.cover});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SERIES_BUNDLE_BOOK_WIDTH + (MARGIN_CARD_MEDIUM_2 * 2),
      height: SERIES_BUNDLE_BOOK_HEIGHT,
      child: Stack(
        children: [
          Positioned.fill(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: SERIES_BUNDLE_BOOK_WIDTH,
                  height: SERIES_BUNDLE_BOOK_HEIGHT,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MARGIN_SMALL),
                    image: DecorationImage(
                      image: NetworkImage(
                        cover ?? "",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: MARGIN_CARD_MEDIUM_2,
                  height: SERIES_BUNDLE_BOOK_HEIGHT - 5,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(MARGIN_MEDIUM),
                      bottomRight: Radius.circular(MARGIN_MEDIUM),
                    ),
                  ),
                ),
                Container(
                  width: MARGIN_CARD_MEDIUM_2,
                  height: SERIES_BUNDLE_BOOK_HEIGHT - 15,
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(MARGIN_MEDIUM),
                      bottomRight: Radius.circular(MARGIN_MEDIUM),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: MARGIN_SMALL),
              child: Text(
                "+6",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FreeSampleAndBuyButtonsView extends StatelessWidget {

  final String? price;

  FreeSampleAndBuyButtonsView({required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.43,
          child: OutlinedButton(
            onPressed: () {},
            child: const Text(FREE_SAMPLE),
          ),
        ),
        const SizedBox(width: MARGIN_MEDIUM),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.43,
          child: ElevatedButton(
            onPressed: () {},
            child: Text("$BUY_BOOK_PRICE${price ?? ""}"),
            style: ElevatedButton.styleFrom(elevation: 0),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class BookReviewsTypeAndPagesView extends StatelessWidget {
  const BookReviewsTypeAndPagesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_XXLARGE,
      child: Row(
        children: [
          const Spacer(),
          Column(
            children: [
              Row(
                children: const [
                  Text(
                    "4.9",
                    style: TextStyle(
                        fontSize: TEXT_CARD_REGULAR_2X,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                  Icon(
                    Icons.grade,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: MARGIN_SMALL),
              const Text(
                "86 reviews",
                style: TextStyle(
                    fontSize: TEXT_SMALL_2,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
            ],
          ),
          const VerticalDivider(
            color: Colors.black12,
            //color of divider
            width: MARGIN_XLARGE,
            //width space of divider
            thickness: 1.5,
            //thickness of divier line
            indent: 10,
            //Spacing at the top of divider.
            endIndent: 10, //Spacing at the bottom of divider.
          ),
          Column(
            children: const [
              Icon(
                IconData(0xe0ef, fontFamily: 'MaterialIcons'),
                color: Colors.grey,
              ),
              SizedBox(height: MARGIN_SMALL),
              Text(
                "Ebook",
                style: TextStyle(
                    fontSize: TEXT_SMALL_2,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
            ],
          ),
          const VerticalDivider(
            color: Colors.black12,
            //color of divider
            width: MARGIN_XLARGE,
            //width space of divider
            thickness: 1.5,
            //thickness of divier line
            indent: 10,
            //Spacing at the top of divider.
            endIndent: 10, //Spacing at the bottom of divider.
          ),
          Column(
            children: const [
              Text(
                "197",
                style: TextStyle(
                    fontSize: TEXT_CARD_REGULAR_2X,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              SizedBox(height: MARGIN_SMALL),
              Text(
                "Pages",
                style: TextStyle(
                    fontSize: TEXT_SMALL_2,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
            ],
          ),
          const VerticalDivider(
            color: Colors.black12,
            //color of divider
            width: MARGIN_XLARGE,
            //width space of divider
            thickness: 1.5,
            //thickness of divier line
            indent: 10,
            //Spacing at the top of divider.
            endIndent: 10, //Spacing at the bottom of divider.
          ),
          Column(
            children: const [
              Icon(
                Icons.question_answer_rounded,
                color: Colors.grey,
              ),
              SizedBox(height: MARGIN_SMALL),
              Text(
                "Bubble Zoom",
                style: TextStyle(
                    fontSize: TEXT_SMALL_2,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
            ],
          ),
          const VerticalDivider(
            color: Colors.black12,
            //color of divider
            width: MARGIN_XLARGE,
            //width space of divider
            thickness: 1.5,
            //thickness of divier line
            indent: 10,
            //Spacing at the top of divider.
            endIndent: 10, //Spacing at the bottom of divider.
          ),
          Column(
            children: const [
              Icon(
                Icons.home_outlined,
                color: Colors.grey,
              ),
              SizedBox(height: MARGIN_SMALL),
              Text(
                "Eligible",
                style: TextStyle(
                    fontSize: TEXT_SMALL_2,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class BookCoverAndInfoView extends StatelessWidget {

  final BookVO? book;

  BookCoverAndInfoView({required this.book});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: MARGIN_LARGE),
        Card(
          elevation: MARGIN_SMALL,
          margin: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
          child: Container(
            width: BOOK_ITEM_WIDTH,
            height: BOOK_ITEM_IMAGE_HEIGHT,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(MARGIN_SMALL),
              image: DecorationImage(
                image: NetworkImage(
                  book?.cover ?? "",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: MARGIN_MEDIUM),
              Text(
                book?.title ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: TEXT_HEADING_1X, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: MARGIN_MEDIUM),
              const Text("Vol 2"),
              const SizedBox(height: MARGIN_SMALL),
              Text(book?.author ?? ""),
              const SizedBox(height: MARGIN_SMALL),
              Text("Sold by ${book?.publisher ?? ""}"),
            ],
          ),
        )
      ],
    );
  }
}
