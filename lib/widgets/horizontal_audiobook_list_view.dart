import 'package:flutter/material.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/audiobook_item_view.dart';

class HorizontalAudiobookListView extends StatelessWidget {
  final Function onTapAudiobook;

  HorizontalAudiobookListView({required this.onTapAudiobook});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
      children: [
        AudiobookItemView(
          onTapAudiobook: onTapAudiobook,
        ),
        AudiobookItemView(
          onTapAudiobook: onTapAudiobook,
        ),
        AudiobookItemView(
          onTapAudiobook: onTapAudiobook,
        ),
        AudiobookItemView(
          onTapAudiobook: onTapAudiobook,
        ),
      ],
    );
  }
}
