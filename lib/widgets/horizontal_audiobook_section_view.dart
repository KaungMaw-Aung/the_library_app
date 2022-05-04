import 'package:flutter/material.dart';
import 'package:the_library_app/resources/dimens.dart';

import 'book_list_title_and_more_button_view.dart';
import 'horizontal_audiobook_list_view.dart';

class HorizontalAudiobookSectionView extends StatelessWidget {
  final String audiobookListTitle;
  final Function onTapAudiobook;
  final Function onAudiobookSectionTitleTap;

  HorizontalAudiobookSectionView({
    required this.audiobookListTitle,
    required this.onTapAudiobook,
    required this.onAudiobookSectionTitleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => onAudiobookSectionTitleTap(),
          child: BookListTitleAndMoreButtonView(
            bookListTitle: audiobookListTitle,
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        SizedBox(
          height: HORIZONTAL_AUDIOBOOK_LIST_HEIGHT,
          child: HorizontalAudiobookListView(
            onTapAudiobook: onTapAudiobook,
          ),
        ),
      ],
    );
  }
}
