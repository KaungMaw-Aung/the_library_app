import 'package:flutter/material.dart';
import 'package:the_library_app/resources/dimens.dart';

class AudiobookItemView extends StatelessWidget {

  final Function onTapAudiobook;

  AudiobookItemView({required this.onTapAudiobook});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapAudiobook(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: MARGIN_SMALL,
            margin: const EdgeInsets.only(right: MARGIN_MEDIUM_2),
            child: Container(
              width: AUDIOBOOK_ITEM_WIDTH,
              height: AUDIOBOOK_ITEM_IMAGE_HEIGHT,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MARGIN_SMALL),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://images-na.ssl-images-amazon.com/images/I/613KCs7szvL.jpg",
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
              "Ugly Love",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey,
                fontSize: TEXT_SMALL_2,
              ),
            ),
          ),
          Container(
            width: BOOK_ITEM_WIDTH,
            child: const Text(
              "Colleen Hoover",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
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
                children: const [
                  TextSpan(
                    text: "\$26.36 ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: TEXT_SMALL_2,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  TextSpan(
                    text: " \$19.99",
                    style: TextStyle(
                      color: Colors.grey,
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
