import 'package:flutter/material.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_item_view.dart';

class HorizontalBookListView extends StatelessWidget {
  final Function onTapBook;
  final Function onTapOverflow;
  final List<BookVO>? books;

  HorizontalBookListView({
    required this.onTapBook,
    required this.onTapOverflow,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
      children: books
              ?.map(
                (book) => BookItemView(
                  onTapBook: onTapBook,
                  onTapOverflow: onTapOverflow,
                  book: book,
                ),
              ).toList() ?? [],
    );
  }
}
