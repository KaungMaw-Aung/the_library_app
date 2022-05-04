import 'package:flutter/material.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/resources/dimens.dart';

class BookListItemView extends StatelessWidget {
  final BookVO book;
  final Function onBookTap;
  final Function onTapOverflow;

  BookListItemView({
    required this.book,
    required this.onBookTap,
    required this.onTapOverflow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onBookTap(),
      child: Container(
        margin: const EdgeInsets.only(bottom: MARGIN_LARGE),
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
                      book.cover ?? "",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: MARGIN_MEDIUM_2),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: MARGIN_MEDIUM),
                  Text(
                    book.author ?? "",
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  const Text(
                    "Ebook - Sample",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: MARGIN_MEDIUM_2),
            const Icon(
              Icons.save_alt_rounded,
              color: Colors.black87,
              size: 20,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => onTapOverflow(),
              child: const Icon(
                Icons.more_horiz,
                color: Colors.black87,
                size: 20,
              ),
            ),
            const SizedBox(width: MARGIN_MEDIUM_2),
          ],
        ),
      ),
    );
  }
}
