import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/shelf_details_bloc.dart';
import 'package:the_library_app/data/vos/book_filter_chip_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';

import 'book_details_page.dart';

class ShelfDetailsPage extends StatelessWidget {
  final String shelfId;

  ShelfDetailsPage({required this.shelfId});

  List<BookFilterChipVO> chipsData = [
    BookFilterChipVO("Not started", false),
    BookFilterChipVO("In progress", false),
  ];
  final List<String> sortByFilters = ["Author", "Recent", "Title"];
  final List<String> viewByFilters = ["Grid 3x", "Grid 2x", "List"];

  /// State Variables
  int? groupValue = 1;
  int? viewFilterGroupValue = 0;
  String selectedSortFilter = "Recent";
  String selectedViewFilter = "Grid 3x";

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShelfDetailsBloc>(
      create: (context) => ShelfDetailsBloc(shelfId),
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
                      onTap: () {
                        _renameShelf(context, shelfId, _controller.text);
                      },
                      child: const Icon(
                        Icons.check,
                        color: Colors.blue,
                      ),
                    )
                  : const Icon(
                      Icons.chevron_left,
                      color: Colors.black,
                      size: MARGIN_XLARGE,
                    );
            },
          ),
          actions: [
            Builder(builder: (context) {
              return GestureDetector(
                onTap: () {
                  ShelfDetailsBloc bloc = Provider.of(context, listen: false);
                  _showOptionsOnBookShelf(
                    context,
                    bloc.shelf?.name ?? "",
                    shelfId,
                  ).then((value) {
                    if (value) {
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
                      : Selector<ShelfDetailsBloc, ShelfVO?>(
                          selector: (context, bloc) => bloc.shelf,
                          builder: (context, shelf, child) {
                            _controller.text = shelf?.name ?? "";
                            return ShelfNameAndBookCountSectionView(
                              shelf: shelf,
                            );
                          },
                        );
                },
              ),
              const Divider(
                color: Colors.black54,
                height: MARGIN_XLARGE,
              ),
              /*BookFilterChipsView(
                chipsData: chipsData,
                onTapChip: (label, isSelected) {
                  setState(() {
                    chipsData = chipsData.map((originalChipData) {
                      if (originalChipData.label == label) {
                        originalChipData.isSelected = isSelected;
                      }
                      return originalChipData;
                    }).toList();
                  });
                },
                onTapClearButton: () {
                  setState(
                    () {
                      chipsData = chipsData.map((chipData) {
                        chipData.isSelected = false;
                        return chipData;
                      }).toList();
                    },
                  );
                },
              ),
              BookGridAndListWithSortAndViewFiltersSectionView(
                selectedSortFilter: selectedSortFilter,
                selectedViewFilter: selectedViewFilter,
                viewByFilters: viewByFilters,
                sortByFilters: sortByFilters,
                books: dummyBooks,
                onSortByFilterTap: () => _showSortByFilterBottomSheet(context),
                onViewByFilterTap: () => _showViewByFilterBottomSheet(context),
                onGridBookTap: (title) => _navigateToBookDetails(context),
                onListBookTap: (title) => _navigateToBookDetails(context),
                onTapOverflow: () => _showMoreOptionsOnBook(context),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

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

  void _showMoreOptionsOnBook(BuildContext context) {
    showModalBottomSheet(
      context: context,
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
                          image: const DecorationImage(
                            image: NetworkImage(
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
                      children: const [
                        Text(
                          "Book Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: MARGIN_SMALL),
                        Text(
                          "Author Name",
                          style: TextStyle(
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
              const ListTile(
                leading: Icon(Icons.add),
                title: Text(
                  ADD_TO_SHELF,
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

  void _navigateToBookDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsPage(
          title: '',
        ),
      ),
    );
  }

/*void _showSortByFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
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
                title: Text(sortByFilters.first),
                onTap: () {
                  setModalState(() {
                    groupValue = 0;
                  });
                  setState(() {
                    selectedSortFilter = sortByFilters.first;
                    dummyBooks.sort((first, second) {
                      return first.author?.codeUnits
                              .reduce(
                                (value, element) => value + element,
                              )
                              .compareTo(
                                second.author?.codeUnits.reduce(
                                      (value, element) => value + element,
                                    ) ??
                                    0,
                              ) ??
                          0;
                    });
                  });
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
                    setState(() {
                      selectedSortFilter = sortByFilters.first;
                      dummyBooks.sort((first, second) {
                        return first.author?.codeUnits
                                .reduce(
                                  (value, element) => value + element,
                                )
                                .compareTo(
                                  second.author?.codeUnits.reduce(
                                        (value, element) => value + element,
                                      ) ??
                                      0,
                                ) ??
                            0;
                      });
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: Text(sortByFilters[1]),
                onTap: () {
                  setModalState(() {
                    groupValue = 1;
                  });
                  setState(() {
                    selectedSortFilter = sortByFilters[1];
                    */ /*dummyBooks.sort((first, second) {
                      return first.createdAt
                              ?.compareTo(second.createdAt ?? 0) ??
                          0;
                    });*/ /*
                  });
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
                    setState(() {
                      selectedSortFilter = sortByFilters[1];
                      */ /*dummyBooks.sort((first, second) {
                        return first.createdAt
                                ?.compareTo(second.createdAt ?? 0) ??
                            0;
                      });*/ /*
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: Text(sortByFilters.last),
                onTap: () {
                  setModalState(() {
                    groupValue = 2;
                  });
                  setState(() {
                    selectedSortFilter = sortByFilters.last;
                    dummyBooks.sort((first, second) {
                      return first.title?.codeUnits
                              .reduce(
                                (value, element) => value + element,
                              )
                              .compareTo(
                                second.title?.codeUnits.reduce(
                                      (value, element) => value + element,
                                    ) ??
                                    0,
                              ) ??
                          0;
                    });
                  });
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
                    setState(() {
                      selectedSortFilter = sortByFilters.last;
                      dummyBooks.sort((first, second) {
                        return first.title?.codeUnits
                                .reduce(
                                  (value, element) => value + element,
                                )
                                .compareTo(
                                  second.title?.codeUnits.reduce(
                                        (value, element) => value + element,
                                      ) ??
                                      0,
                                ) ??
                            0;
                      });
                    });
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

  void _showViewByFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
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
                title: Text(viewByFilters.first),
                onTap: () {
                  setModalState(() {
                    viewFilterGroupValue = 0;
                  });
                  setState(() {
                    selectedViewFilter = viewByFilters.first;
                  });
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
                    setState(() {
                      selectedViewFilter = viewByFilters.first;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: Text(viewByFilters[1]),
                onTap: () {
                  setModalState(() {
                    viewFilterGroupValue = 1;
                  });
                  setState(() {
                    selectedViewFilter = viewByFilters[1];
                  });
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
                    setState(() {
                      selectedViewFilter = viewByFilters[1];
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              ListTile(
                title: Text(viewByFilters.last),
                onTap: () {
                  setModalState(() {
                    viewFilterGroupValue = 2;
                  });
                  setState(() {
                    selectedViewFilter = viewByFilters.last;
                  });
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
                    setState(() {
                      selectedViewFilter = viewByFilters.last;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          );
        });
      },
    );
  }*/
}

class ShelfNameAndBookCountSectionView extends StatelessWidget {
  ShelfVO? shelf;

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
