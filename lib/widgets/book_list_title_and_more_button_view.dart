import 'package:flutter/material.dart';
import 'package:the_library_app/resources/dimens.dart';

class BookListTitleAndMoreButtonView extends StatelessWidget {
  final String bookListTitle;

  BookListTitleAndMoreButtonView({required this.bookListTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: MARGIN_MEDIUM,
      ),
      child: Row(
        children: [
          const SizedBox(width: MARGIN_MEDIUM_2),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              bookListTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: TEXT_CARD_REGULAR_2X,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.chevron_right,
            color: Colors.blue,
            size: MARGIN_XLARGE,
          ),
          const SizedBox(width: MARGIN_MEDIUM),
        ],
      ),
    );
  }
}
