import 'package:flutter/material.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_item_view.dart';

class HorizontalBookListView extends StatelessWidget {
  final Function onTapBook;
  final Function onTapOverflow;

  HorizontalBookListView({
    required this.onTapBook,
    required this.onTapOverflow,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
      children: [
        BookItemView(
          onTapBook: onTapBook,
          onTapOverflow: onTapOverflow,
        ),
        BookItemView(
          onTapBook: onTapBook,
          onTapOverflow: onTapOverflow,
        ),
        BookItemView(
          onTapBook: onTapBook,
          onTapOverflow: onTapOverflow,
        ),
        BookItemView(
          onTapBook: onTapBook,
          onTapOverflow: onTapOverflow,
        ),
      ],
    );
  }
}
