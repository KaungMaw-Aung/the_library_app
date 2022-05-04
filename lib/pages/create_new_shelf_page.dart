import 'package:flutter/material.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';

class CreateNewShelfPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: MARGIN_MEDIUM_2),
            Container(
              margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              child: GestureDetector(
                onTap: () => _createNewShelf(context),
                child: const Icon(
                  Icons.check,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: MARGIN_LARGE),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: SHELF_NAME,
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  )
                ),
                style: TextStyle(
                  fontSize: TEXT_HEADING_1X,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: MARGIN_LARGE),
            const Divider(
              color: Colors.black54,
              height: MARGIN_LARGE,
            )
          ],
        ),
      ),
    );
  }

  void _createNewShelf(BuildContext context) {
    Navigator.pop(context);
  }

}
