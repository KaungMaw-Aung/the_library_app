import 'package:flutter/material.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';

class BookShelfView extends StatelessWidget {
  final Function onShelfTap;
  final ShelfVO shelf;

  BookShelfView({
    required this.onShelfTap,
    required this.shelf,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => onShelfTap(),
          child: SizedBox(
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
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            shelf.books.isNotEmpty
                                ? shelf.books.first.cover ?? ""
                                : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiQJF2fyjbUEkuy4JI84obHhL74uXwwtlu8A&usqp=CAU",
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(MARGIN_MEDIUM),
                          topRight: Radius.circular(MARGIN_MEDIUM),
                        ),
                      ),
                    ),
                    const SizedBox(width: MARGIN_MEDIUM),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: MARGIN_SMALL),
                          Text(
                            shelf.name,
                            style: const TextStyle(
                              fontSize: TEXT_CARD_REGULAR_2X,
                              fontWeight: FontWeight.w700,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: MARGIN_MEDIUM),
                          Text(
                            shelf.books.isNotEmpty
                                ? "${shelf.books.length} books"
                                : EMPTY,
                            style: const TextStyle(
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
          ),
        ),
        const SizedBox(height: MARGIN_LARGE),
      ],
    );
  }
}
