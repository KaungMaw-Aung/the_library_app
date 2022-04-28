import 'package:flutter/material.dart';
import 'package:the_library_app/resources/dimens.dart';

class CarouselItemView extends StatelessWidget {
  final Function onTapCarouselItem;

  CarouselItemView({required this.onTapCarouselItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: MARGIN_MEDIUM_2,
        horizontal: MARGIN_SMALL,
      ),
      child: GestureDetector(
        onTap: () => onTapCarouselItem(),
        child: PhysicalModel(
          color: Colors.transparent,
          elevation: MARGIN_MEDIUM,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(MARGIN_CARD_MEDIUM_2),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/action-thriller-book-cover-design-template-3675ae3e3ac7ee095fc793ab61b812cc_screen.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: MARGIN_MEDIUM),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                      size: MARGIN_XLARGE,
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
