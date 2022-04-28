import 'package:flutter/material.dart';
import 'package:the_library_app/resources/dimens.dart';

import 'book_list_title_and_more_button_view.dart';
import 'horizontal_book_list_view.dart';

class HorizontalBookSectionView extends StatelessWidget {
  final String bookListTitle;
  final Function onTapBook;

  HorizontalBookSectionView({
    required this.bookListTitle,
    required this.onTapBook,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => print("Tapped"),
          child: BookListTitleAndMoreButtonView(
            bookListTitle: bookListTitle,
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        SizedBox(
          height: HORIZONTAL_BOOK_LIST_HEIGHT,
          child: HorizontalBookListView(
            onTapBook: onTapBook,
          ),
        ),
      ],
    );
  }
}
