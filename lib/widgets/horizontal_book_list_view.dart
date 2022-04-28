import 'package:flutter/material.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_item_view.dart';

class HorizontalBookListView extends StatelessWidget {
  final Function onTapBook;

  HorizontalBookListView({required this.onTapBook});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
      children: [
        BookItemView(
          onTapBook: onTapBook,
        ),
        BookItemView(
          onTapBook: onTapBook,
        ),
        BookItemView(
          onTapBook: onTapBook,
        ),
        BookItemView(
          onTapBook: onTapBook,
        ),
      ],
    );
  }
}
