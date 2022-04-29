import 'package:flutter/material.dart';
import 'package:the_library_app/resources/dimens.dart';

class BookShelfView extends StatelessWidget {
  const BookShelfView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SHELF_BOOK_COVER_HEIGHT + 1,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: MARGIN_MEDIUM_2),
              Container(
                width: SHELF_BOOK_COVER_WIDTH,
                height: SHELF_BOOK_COVER_HEIGHT,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://images-na.ssl-images-amazon.com/images/I/715FyFCzwYL.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(MARGIN_MEDIUM),
                    topRight:
                    Radius.circular(MARGIN_MEDIUM),
                  ),
                ),
              ),
              const SizedBox(width: MARGIN_MEDIUM),
              SizedBox(
                width:
                MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: MARGIN_SMALL),
                    Text(
                      "10 interaction Design Books to Read",
                      style: TextStyle(
                        fontSize: TEXT_CARD_REGULAR_2X,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: MARGIN_MEDIUM),
                    Text(
                      "3 books",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: SHELF_BOOK_COVER_HEIGHT,
                child: Center(
                  child: Icon(
                    Icons.chevron_right,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.black54,
            height: 0,
          )
        ],
      ),
    );
  }
}