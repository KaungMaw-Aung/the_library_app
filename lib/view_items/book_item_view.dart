import 'package:flutter/material.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/resources/dimens.dart';

class BookItemView extends StatelessWidget {
  final Function onTapBook;
  final Function onTapOverflow;
  final BookVO? book;

  BookItemView({
    required this.book,
    required this.onTapBook,
    required this.onTapOverflow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapBook(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: MARGIN_SMALL),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: PhysicalModel(
                        color: Colors.transparent,
                        elevation: MARGIN_MEDIUM_2,
                        child: GestureDetector(
                          onTap: () => onTapOverflow(),
                          child: const Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: MARGIN_MEDIUM),
          Container(
            width: BOOK_ITEM_WIDTH,
            child: Text(
              book?.title ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: TEXT_SMALL_2,
              ),
            ),
          ),
          Container(
            width: BOOK_ITEM_WIDTH,
            child: Text(
              book?.author ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: TEXT_SMALL_2,
              ),
            ),
          ),
          const SizedBox(height: MARGIN_SMALL),
          Container(
            width: BOOK_ITEM_WIDTH,
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  const TextSpan(
                    text: "\$37.44 ",
                    style: TextStyle(
                      fontSize: TEXT_SMALL_2,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  TextSpan(
                    text: " \$${book?.price ?? ""}",
                    style: const TextStyle(
                      fontSize: TEXT_SMALL_2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: MARGIN_SMALL),
        ],
      ),
    );
  }
}
