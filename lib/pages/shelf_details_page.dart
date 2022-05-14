import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/shelf_details_bloc.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';
import 'package:the_library_app/widgets/book_filter_chips_view.dart';
import 'package:the_library_app/widgets/book_grid_and_list_with_sort_and_view_filters_section_view.dart';

import 'book_details_page.dart';

class ShelfDetailsPage extends StatelessWidget {
  final String shelfId;

  ShelfDetailsPage({required this.shelfId});

  /// State Variables
  int? groupValue = 1;
  int? viewFilterGroupValue = 0;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShelfDetailsBloc>.value(
      value: ShelfDetailsBloc(shelfId),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Selector<ShelfDetailsBloc, bool>(
            selector: (context, bloc) => bloc.showShelfEditViews,
            builder: (context, showShelfEditViews, child) {
              return showShelfEditViews
                  ? GestureDetector(
                      key: const Key("rename"),
                      onTap: () {
                        _renameShelf(context, shelfId, _controller.text);
                      },
                      child: const Icon(
                        Icons.check,
                        key: Key("confirm rename"),
                        color: Colors.blue,
                      ),
                    )
                  : GestureDetector(
                      key: const Key("back"),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                        size: MARGIN_XLARGE,
                      ),
                    );
            },
          ),
          actions: [
            Builder(builder: (context) {
              return GestureDetector(
                key: const Key("shelf overflow"),
                onTap: () {
                  ShelfDetailsBloc bloc = Provider.of(context, listen: false);
                  _showOptionsOnBookShelf(
                    context,
                    bloc.shelf?.name ?? "",
                    shelfId,
                  ).then((value) {
                    if (value == true) {
                      Navigator.pop(context);
                    }
                  });
                },
                child: const Icon(
                  Icons.more_horiz,
                  color: Colors.black,
                ),
              );
            }),
            const SizedBox(width: MARGIN_MEDIUM_2),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: MARGIN_MEDIUM_2),
              Selector<ShelfDetailsBloc, bool>(
                selector: (context, bloc) => bloc.showShelfEditViews,
                builder: (context, showShelfEditViews, child) {
                  return showShelfEditViews
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: MARGIN_MEDIUM_3,
                          ),
                          child: Builder(builder: (context) {
                            return TextField(
                              controller: _controller,
                              autofocus: true,
                              decoration: const InputDecoration(
                                hintText: SHELF_NAME,
                                hintStyle: TextStyle(
                                  color: Colors.black38,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: TEXT_HEADING_1X,
                                fontWeight: FontWeight.w500,
                              ),
                              onSubmitted: (name) {
                                _renameShelf(
                                    context, shelfId, _controller.text);
                              },
                            );
                          }),
                        )
                      : Consumer<ShelfDetailsBloc>(
                          builder: (context, bloc, child) {
                            _controller.text = bloc.shelf?.name ?? "";
                            return ShelfNameAndBookCountSectionView(
                              shelf: bloc.shelf,
                            );
                          },
                        );
                },
              ),
              const Divider(
                color: Colors.black54,
                height: MARGIN_XLARGE,
              ),
              Consumer<ShelfDetailsBloc>(
                builder: (context, bloc, child) {
                  return BookFilterChipsView(
                    chipsData: bloc.chipsData ?? [],
                    onTapChip: (label, isSelected) {
                      bloc.onTapChip(label, isSelected);
                    },
                    onTapClearButton: () {
                      bloc.onTapClearButton();
                    },
                  );
                },
              ),
              Consumer<ShelfDetailsBloc>(
                builder: (context, bloc, child) {
                  return bloc.books != null && bloc.books!.isNotEmpty
                      ? BookGridAndListWithSortAndViewFiltersSectionView(
                          selectedSortFilter: bloc.selectedSortFilter,
                          selectedViewFilter: bloc.selectedViewFilter,
                          viewByFilters: bloc.viewByFilters,
                          sortByFilters: bloc.sortByFilters,
                          books: bloc.books,
                          onSortByFilterTap: () =>
                              _showSortByFilterBottomSheet(context),
                          onViewByFilterTap: () =>
                              _showViewByFilterBottomSheet(context),
                          onGridBookTap: (title) {
                            bloc.shelf?.books
                                .firstWhere((element) => element.title == title)
                                .visitedAt = DateTime.now();
                            if (bloc.shelf != null) {
                              bloc.updateShelf(bloc.shelf!);
                            }
                            _navigateToBookDetails(context, title);
                          },
                          onListBookTap: (title) {
                            bloc.shelf?.books
                                .firstWhere((element) => element.title == title)
                                .visitedAt = DateTime.now();
                            if (bloc.shelf != null) {
                              bloc.updateShelf(bloc.shelf!);
                            }
                            _navigateToBookDetails(context, title);
                          },
                          onTapOverflow: (book) =>
                              _showMoreOptionsOnBook(context, book),
                        )
                      : Center(
                          child: Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.3,
                            ),
                            child: const Text(YOUR_SHELF_IS_EMPTY),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*void _showAlertDialog(BuildContext context, String shelfName) {
    AlertDialog(
      title: Text("Delete $shelfName"),
      content: const Text(
        "This shelf will be deleted from all of your devices. Purchases, samples, uploads, and active rentals on this shelf will stay in \"Your books\".",
      ),
      actions: [
        TextButton(
          onPressed: () {
            print("dismissed");
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            print("confirm");
          },
          child: const Text("Delete"),
        ),
      ],
    ).build(context);
  }*/

  void _renameShelf(BuildContext context, String shelfId, String updatedName) {
    if (updatedName.isNotEmpty) {
      ShelfDetailsBloc bloc = Provider.of(context, listen: false);
      bloc.updateShelfName(shelfId, updatedName);
      bloc.doneEditShelf();
    } else {
      showShelfNameEmptyWarningSheet(context);
    }
  }

  void showShelfNameEmptyWarningSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            const ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: MARGIN_LARGE),
              title: Text(
                COULD_NOT_CREATE_THIS_SHELF,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: TEXT_CARD_REGULAR_2X,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.black12,
            ),
            const ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: MARGIN_LARGE),
              title: Text(
                ENTER_A_SHELF_NAME,
                style: TextStyle(fontSize: TEXT_REGULAR, color: Colors.black54),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: MARGIN_LARGE,
                right: MARGIN_LARGE,
                bottom: MARGIN_LARGE,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(OK),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> _showOptionsOnBookShelf(
    BuildContext buildContext,
    String shelfName,
    String shelfId,
  ) {
    return showModalBottomSheet(
      context: buildContext,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Wrap(
              children: [
                ListTile(
                  title: Text(
                    shelfName,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const Divider(
                  color: Colors.black54,
                  height: 0.0,
                ),
                ListTile(
                  onTap: () {
                    ShelfDetailsBloc bloc = Provider.of(
                      buildContext,
                      listen: false,
                    );
                    bloc.onTapEditShelf();
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.edit_outlined),
                  title: const Text(
                    RENAME_SHELF,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    ShelfDetailsBloc bloc = Provider.of(
                      buildContext,
                      listen: false,
                    );
                    bloc.deleteShelfById(shelfId);
                    Navigator.pop(context, true);
                  },
                  leading: const Icon(Icons.delete),
                  title: const Text(
                    DELETE_SHELF,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showMoreOptionsOnBook(BuildContext buildContext, BookVO? book) {
    showModalBottomSheet(
      context: buildContext,
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Wrap(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: MARGIN_MEDIUM_2),
                    Card(
                      elevation: MARGIN_SMALL,
                      margin: EdgeInsets.zero,
                      child: Container(
                        width: BOOK_LIST_ITEM_COVER_WIDTH,
                        height: BOOK_LIST_ITEM_HEIGHT,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(MARGIN_SMALL),
                          image: DecorationImage(
                            image: NetworkImage(
                              book?.cover ??
                                  "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/action-thriller-book-cover-design-template-3675ae3e3ac7ee095fc793ab61b812cc_screen.jpg?ts=1637008457",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: MARGIN_MEDIUM_2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book?.title ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: MARGIN_SMALL),
                        Text(
                          book?.author ?? "",
                          style: const TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Divider(
                color: Colors.black54,
                height: 0.0,
              ),
              const ListTile(
                leading: Icon(Icons.remove_circle_outline_rounded),
                title: Text(
                  REMOVE_DOWNLOAD,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  DELETE_FROM_LIBRARY,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  ShelfDetailsBloc bloc =
                      Provider.of(buildContext, listen: false);
                  bloc.removeBookFromShelf(book);
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.add),
                title: const Text(
                  REMOVE_FROM_SHELF,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.book_rounded),
                title: Text(
                  ABOUT_THIS_EBOOK,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: MARGIN_SMALL,
                  left: MARGIN_MEDIUM_2,
                  right: MARGIN_MEDIUM_2,
                  bottom: MARGIN_MEDIUM_2,
                ),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Buy \$4.99"),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  void _navigateToBookDetails(BuildContext context, String bookTitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsPage(title: bookTitle),
      ),
    );
  }

  void _showSortByFilterBottomSheet(BuildContext buildContext) {
    showModalBottomSheet(
      context: buildContext,
      builder: (context) {
        ShelfDetailsBloc bloc = Provider.of(buildContext, listen: false);
        return StatefulBuilder(builder: (context, setModalState) {
          return Wrap(
            children: [
              const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: MARGIN_LARGE),
                title: Text(
                  SORT_BY,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: TEXT_CARD_REGULAR_2X,
                  ),
                ),
              ),
              const Divider(
                color: Colors.black54,
                height: MARGIN_MEDIUM,
              ),
              ListTile(
                title: Text(bloc.sortByFilters.first),
                onTap: () {
                  setModalState(() {
                    groupValue = 0;
                  });
                  bloc.onTapSortByFilter(bloc.sortByFilters.first);
                  Navigator.pop(context);
                },
                leading: Radio(
                  value: 0,
                  groupValue: groupValue,
                  activeColor: Colors.blue,
                  onChanged: (int? value) {
                    setModalState(() {
                      groupValue = value;
                    });
                    bloc.onTapSortByFilter(bloc.sortByFilters.first);
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: Text(bloc.sortByFilters[1]),
                onTap: () {
                  setModalState(() {
                    groupValue = 1;
                  });
                  bloc.onTapSortByFilter(bloc.sortByFilters[1]);
                  Navigator.pop(context);
                },
                leading: Radio(
                  value: 1,
                  groupValue: groupValue,
                  activeColor: Colors.blue,
                  onChanged: (int? value) {
                    setModalState(() {
                      groupValue = value;
                    });
                    bloc.onTapSortByFilter(bloc.sortByFilters[1]);
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: Text(bloc.sortByFilters.last),
                onTap: () {
                  setModalState(() {
                    groupValue = 2;
                  });
                  bloc.onTapSortByFilter(bloc.sortByFilters.last);
                  Navigator.pop(context);
                },
                leading: Radio(
                  value: 2,
                  groupValue: groupValue,
                  activeColor: Colors.blue,
                  onChanged: (int? value) {
                    setModalState(() {
                      groupValue = value;
                    });
                    bloc.onTapSortByFilter(bloc.sortByFilters.last);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        });
      },
    );
  }

  void _showViewByFilterBottomSheet(BuildContext buildContext) {
    showModalBottomSheet(
      context: buildContext,
      builder: (context) {
        ShelfDetailsBloc bloc = Provider.of(buildContext, listen: false);
        return StatefulBuilder(builder: (context, setModalState) {
          return Wrap(
            children: [
              const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: MARGIN_LARGE),
                title: Text(
                  VIEW_BY,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: TEXT_CARD_REGULAR_2X,
                  ),
                ),
              ),
              const Divider(
                color: Colors.black54,
                height: MARGIN_MEDIUM,
              ),
              ListTile(
                title: Text(bloc.viewByFilters.first),
                onTap: () {
                  setModalState(() {
                    viewFilterGroupValue = 0;
                  });
                  bloc.onTapViewByFilter(bloc.viewByFilters.first);
                  Navigator.pop(context);
                },
                leading: Radio(
                  value: 0,
                  groupValue: viewFilterGroupValue,
                  activeColor: Colors.blue,
                  onChanged: (int? value) {
                    setModalState(() {
                      viewFilterGroupValue = value;
                    });
                    bloc.onTapViewByFilter(bloc.viewByFilters.first);
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: Text(bloc.viewByFilters[1]),
                onTap: () {
                  setModalState(() {
                    viewFilterGroupValue = 1;
                  });
                  bloc.onTapViewByFilter(bloc.viewByFilters[1]);
                  Navigator.pop(context);
                },
                leading: Radio(
                  value: 1,
                  groupValue: viewFilterGroupValue,
                  activeColor: Colors.blue,
                  onChanged: (int? value) {
                    setModalState(() {
                      viewFilterGroupValue = value;
                    });
                    bloc.onTapViewByFilter(bloc.viewByFilters[1]);
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: Text(bloc.viewByFilters.last),
                onTap: () {
                  setModalState(() {
                    viewFilterGroupValue = 2;
                  });
                  bloc.onTapViewByFilter(bloc.viewByFilters.last);
                  Navigator.pop(context);
                },
                leading: Radio(
                  value: 2,
                  groupValue: viewFilterGroupValue,
                  activeColor: Colors.blue,
                  onChanged: (int? value) {
                    setModalState(() {
                      viewFilterGroupValue = value;
                    });
                    bloc.onTapViewByFilter(bloc.viewByFilters.last);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        });
      },
    );
  }
}

class ShelfNameAndBookCountSectionView extends StatelessWidget {
  final ShelfVO? shelf;

  ShelfNameAndBookCountSectionView({required this.shelf});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: Text(
            shelf?.name ?? "",
            style: const TextStyle(
              fontSize: TEXT_HEADING_2X,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: Text(
            (shelf != null && shelf!.books.isNotEmpty)
                ? "${shelf!.books.length} books"
                : EMPTY,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
