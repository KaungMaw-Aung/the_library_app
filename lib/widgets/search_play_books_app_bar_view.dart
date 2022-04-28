import 'package:flutter/material.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';

class SearchPlayBooksAppBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(MARGIN_MEDIUM_2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(MARGIN_MEDIUM),
        ),
      ),
      child: InkWell(
        onTap: () => print("Search Box Tapped"),
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        child: Column(
          children: [
            const Spacer(),
            Row(
              children: const [
                SizedBox(width: MARGIN_MEDIUM_2),
                Icon(Icons.search),
                SizedBox(width: MARGIN_MEDIUM_2),
                Text(
                  SEARCH_PLAY_BOOKS,
                  style: TextStyle(fontSize: TEXT_REGULAR_2X),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzfG4grVjejPN1T_WwTFu0ig24GINUAjokZA&usqp=CAU",
                  ),
                ),
                SizedBox(width: MARGIN_MEDIUM),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
