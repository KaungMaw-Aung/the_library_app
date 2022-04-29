import 'package:flutter/material.dart';
import 'package:the_library_app/resources/dimens.dart';

class RelatedBookItemView extends StatelessWidget {
  const RelatedBookItemView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: MARGIN_SMALL,
          margin:
          const EdgeInsets.only(right: MARGIN_MEDIUM_2),
          child: Container(
            width: RELATED_BOOK_WIDTH,
            height: RELATED_BOOK_HEIGHT,
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(MARGIN_SMALL),
              image: const DecorationImage(
                image: NetworkImage(
                  "http://prodimage.images-bn.com/pimages/9781974718160_p0_v1_s1200x630.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        Container(
          width: BOOK_ITEM_WIDTH,
          child: const Text(
            "Spy x Family",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey,
              fontSize: TEXT_SMALL_2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          width: BOOK_ITEM_WIDTH,
          child: const Text(
            "Vol 3",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey,
              fontSize: TEXT_SMALL_2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          children: const [
            Text(
              "4.9",
              style: TextStyle(
                color: Colors.grey,
                fontSize: TEXT_SMALL_2,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: MARGIN_SMALL),
            Icon(
              Icons.star,
              color: Colors.grey,
              size: TEXT_SMALL_2,
            ),
            SizedBox(width: MARGIN_SMALL),
            Text(
              "\$9.61",
              style: TextStyle(
                color: Colors.grey,
                fontSize: TEXT_SMALL_2,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        const SizedBox(height: MARGIN_SMALL),
      ],
    );
  }
}