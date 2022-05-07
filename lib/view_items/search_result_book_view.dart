import 'package:flutter/material.dart';
import 'package:the_library_app/resources/dimens.dart';

class SearchResultBookView extends StatelessWidget {
  final String cover;
  final String title;
  final String author;
  final Function(String) onTapResult;

  SearchResultBookView({
    required this.cover,
    required this.title,
    required this.author,
    required this.onTapResult,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapResult(title),
      child: Container(
        margin: const EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
        height: SEARCH_RESULT_BOOK_ITEM_HEIGHT,
        child: Row(
          children: [
            const SizedBox(width: MARGIN_XLARGE),
            Container(
              height: SEARCH_RESULT_BOOK_COVER_HEIGHT,
              width: SEARCH_RESULT_BOOK_COVER_WIDHT,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    cover,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: MARGIN_MEDIUM_2),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: MARGIN_MEDIUM),
                  Text(
                    author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}