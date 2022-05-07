import 'package:flutter/material.dart';
import 'package:the_library_app/data/vos/book_filter_chip_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';
import 'package:the_library_app/widgets/book_filter_chips_view.dart';
import 'package:the_library_app/widgets/book_grid_and_list_with_sort_and_view_filters_section_view.dart';

import 'book_details_page.dart';

class ShelfDetailsPage extends StatefulWidget {
  @override
  State<ShelfDetailsPage> createState() => _ShelfDetailsPageState();
}

class _ShelfDetailsPageState extends State<ShelfDetailsPage> {
  List<BookFilterChipVO> chipsData = [
    BookFilterChipVO("Not started", false),
    BookFilterChipVO("In progress", false),
  ];
  final List<String> sortByFilters = ["Author", "Recent", "Title"];
  final List<String> viewByFilters = ["Grid 3x", "Grid 2x", "List"];

  /// Dummy Data
  List<BookVO> dummyBooks = [
    BookVO(
      "https://i.pinimg.com/originals/ed/5f/51/ed5f51b122684dd72381f09c8fc39cbe.jpg",
      "Book One",
      "Author One",
      "Description",
      "0.0",
      "Publisher",
      DateTime.now(),
      "comedy",
    ),
    BookVO(
      "https://www.theyoungfolks.com/wp-content/uploads/2017/08/six-of-crows-770x1156.jpg",
      "Book Two",
      "Author Two",
      "Description",
      "0.0",
      "Publisher",
      DateTime.now(),
      "comedy",
    ),
    BookVO(
      "https://rivetedlit.com/wp-content/uploads/2020/01/all-this-time-9781534466340_xlg.jpg",
      "Book Three",
      "Author Three",
      "Description",
      "0.0",
      "Publisher",
      DateTime.now(),
      "comedy",
    ),
    BookVO(
      "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/action-thriller-book-cover-design-template-3675ae3e3ac7ee095fc793ab61b812cc_screen.jpg?ts=1637008457",
      "Book Four",
      "Author Four",
      "Description",
      "0.0",
      "Publisher",
      DateTime.now(),
      "comedy",
    ),
    BookVO(
      "https://marketplace.canva.com/EAD7WuSVrt0/1/0/1003w/canva-colorful-illustration-young-adult-book-cover-LVthABb24ik.jpg",
      "Book Five",
      "Author Five",
      "Description",
      "0.0",
      "Publisher",
      DateTime.now(),
      "comedy",
    ),
    BookVO(
      "https://www.skipprichard.com/wp-content/uploads/2019/12/9780525645580.jpg",
      "Book Six",
      "Author Six",
      "Description",
      "0.0",
      "Publisher",
      DateTime.now(),
      "comedy",
    ),
    BookVO(
      "https://img.buzzfeed.com/buzzfeed-static/static/2020-12/22/20/asset/d501ee3b6aaa/sub-buzz-8285-1608667292-7.jpg?downsize=700%3A%2A&output-quality=auto&output-format=auto",
      "Book Seven",
      "Author Seven",
      "Description",
      "0.0",
      "Publisher",
      DateTime.now(),
      "comedy",
    ),
    BookVO(
      "http://bukovero.com/wp-content/uploads/2016/07/Harry_Potter_and_the_Cursed_Child_Special_Rehearsal_Edition_Book_Cover.jpg",
      "Book Eight",
      "Author Eight",
      "Description",
      "0.0",
      "Publisher",
      DateTime.now(),
      "comedy",
    ),
    BookVO(
      "https://edit.org/photos/images/cat/book-covers-big-2019101610.jpg-1300.jpg",
      "Book Nine",
      "Author Nine",
      "Description",
      "0.0",
      "Publisher",
      DateTime.now(),
      "comedy",
    ),
  ];

  /// State Variables
  int? groupValue = 1;
  int? viewFilterGroupValue = 0;
  String selectedSortFilter = "Recent";
  String selectedViewFilter = "Grid 3x";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.chevron_left,
          color: Colors.black,
          size: MARGIN_XLARGE,
        ),
        actions: [
          GestureDetector(
            onTap: () => _showOptionsOnBookShelf(context),
            child: const Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: MARGIN_MEDIUM_2),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: MARGIN_XLARGE),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: const Text(
                "10 Interaction Design Books to Read",
                style: TextStyle(
                  fontSize: TEXT_HEADING_2X,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: MARGIN_MEDIUM),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: const Text(
                "3 books",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
            const Divider(
              color: Colors.black54,
              height: MARGIN_XLARGE,
            ),
            BookFilterChipsView(
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
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsOnBookShelf(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Wrap(
            children: const [
              ListTile(
                title: Text(
                  "10 Interaction Design Books to Read",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Divider(
                color: Colors.black54,
                height: 0.0,
              ),
              ListTile(
                leading: Icon(Icons.edit_outlined),
                title: Text(
                  RENAME_SHELF,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text(
                  DELETE_SHELF,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          );
        });
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
        builder: (context) => BookDetailsPage(title: '',),
      ),
    );
  }

  void _showSortByFilterBottomSheet(BuildContext context) {
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
                    /*dummyBooks.sort((first, second) {
                      return first.createdAt
                              ?.compareTo(second.createdAt ?? 0) ??
                          0;
                    });*/
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
                      /*dummyBooks.sort((first, second) {
                        return first.createdAt
                                ?.compareTo(second.createdAt ?? 0) ??
                            0;
                      });*/
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
                        ) ?? 0,
                      ) ?? 0;
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
                          ) ?? 0,
                        ) ?? 0;
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
  }
}
