import 'package:flutter/material.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/resources/dimens.dart';

class BookGridItemView extends StatelessWidget {
  final BookVO book;
  final int gridCount;
  final Function onBookTap;
  final Function onOverflowTap;

  BookGridItemView({
    required this.book,
    required this.gridCount,
    required this.onBookTap,
    required this.onOverflowTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onBookTap(),
      child: Container(
        margin: const EdgeInsets.all(MARGIN_MEDIUM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: MARGIN_SMALL,
              margin: EdgeInsets.zero,
              child: Container(
                height: gridCount == 2
                    ? BOOK_ITEM_IMAGE_2X_HEIGHT
                    : BOOK_ITEM_IMAGE_HEIGHT,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MARGIN_SMALL),
                  image: DecorationImage(
                    image: NetworkImage(
                      book.cover ?? "",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: MARGIN_SMALL,
                        top: MARGIN_SMALL,
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 50,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(
                              MARGIN_SMALL,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Sample",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: TEXT_SMALL_2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: MARGIN_SMALL),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: PhysicalModel(
                          color: Colors.transparent,
                          elevation: MARGIN_MEDIUM_2,
                          child: GestureDetector(
                            onTap: () => onOverflowTap(),
                            child: const Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(MARGIN_MEDIUM),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(MARGIN_SMALL),
                            child: Icon(
                              Icons.save_alt_rounded,
                              color: Colors.white,
                              size: 18,
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
            Text(
              book.title ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: TEXT_SMALL_2,
              ),
            ),
            Text(
              book.author ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: TEXT_SMALL_2,
              ),
            ),
            const SizedBox(height: MARGIN_SMALL),
          ],
        ),
      ),
    );
  }
}
