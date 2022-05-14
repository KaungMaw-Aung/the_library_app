import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/add_to_shelf_bloc.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';
import 'package:the_library_app/view_items/book_shelf_view.dart';

class AddToShelfPage extends StatelessWidget {
  final BookVO? book;

  AddToShelfPage(this.book);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddToShelfBloc>.value(
      value: AddToShelfBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: const Icon(
            Icons.chevron_left,
            color: Colors.black54,
            size: MARGIN_XLARGE,
          ),
          title: const Text(
            ADD_TO_SHELF,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Selector<AddToShelfBloc, List<ShelfVO>?>(
          selector: (context, bloc) => bloc.shelves,
          shouldRebuild: (oldValue, newValue) => oldValue != newValue,
          builder: (context, shelves, child) {
            return ListView(
              padding: const EdgeInsets.only(top: MARGIN_LARGE),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: shelves
                      ?.map(
                        (shelf) => BookShelfView(
                          onShelfTap: (shelfId) {
                            AddToShelfBloc bloc = Provider.of(context, listen: false);
                            bloc.addBookToShelf(shelfId, book);
                            Navigator.pop(context);
                          },
                          shelf: shelf,
                        ),
                      ).toList() ?? [],
            );
          },
        ),
      ),
    );
  }
}
