import 'package:flutter/material.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/resources/dimens.dart';

class CarouselItemView extends StatelessWidget {
  final BookVO? visitedBook;
  final Function(String) onTapCarouselItem;
  final Function(BookVO?) onOverflowTap;

  CarouselItemView({
    required this.onTapCarouselItem,
    required this.onOverflowTap,
    required this.visitedBook,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: MARGIN_MEDIUM_2,
        horizontal: MARGIN_SMALL,
      ),
      child: GestureDetector(
        onTap: () => onTapCarouselItem(visitedBook?.title ?? ""),
        child: PhysicalModel(
          color: Colors.transparent,
          elevation: MARGIN_MEDIUM,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(MARGIN_CARD_MEDIUM_2),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  visitedBook?.cover ?? "",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: MARGIN_MEDIUM),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => onOverflowTap(visitedBook),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: MARGIN_XLARGE,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(MARGIN_MEDIUM),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(MARGIN_SMALL),
                        child: Icon(
                          Icons.headphones_outlined,
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
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
