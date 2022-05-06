import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:the_library_app/data/vos/book_filter_chip_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/pages/create_new_shelf_page.dart';
import 'package:the_library_app/pages/shelf_details_page.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';
import 'package:the_library_app/view_items/book_shelf_view.dart';
import 'package:the_library_app/widgets/book_filter_chips_view.dart';
import 'package:the_library_app/widgets/book_grid_and_list_with_sort_and_view_filters_section_view.dart';
import 'package:the_library_app/widgets/search_play_books_app_bar_view.dart';

import 'book_details_page.dart';

class LibraryPage extends StatefulWidget {
  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final List<String> tabLabels = [YOUR_BOOKS_TAB_LABEL, YOUR_SHELVES_TAB_LABEL];
  final List<String> sortByFilters = ["Author", "Recent", "Title"];
  final List<String> viewByFilters = ["Grid 3x", "Grid 2x", "List"];

  /// State Variables
  int selectedTabIndex = 0;
  List<BookFilterChipVO> chipsData = [
    BookFilterChipVO("Ebooks", false),
    BookFilterChipVO("Purchases", false),
    BookFilterChipVO("Samples", false),
    BookFilterChipVO("Downloaded", false),
  ];
  int? groupValue = 1;
  int? viewFilterGroupValue = 0;
  String selectedSortFilter = "Recent";
  String selectedViewFilter = "Grid 3x";

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
    ),
    BookVO(
      "https://www.theyoungfolks.com/wp-content/uploads/2017/08/six-of-crows-770x1156.jpg",
      "Book Two",
      "Author Two",
      "Description",
      "0.0",
      "Publisher",
      DateTime.now(),
    ),
    BookVO(
      "https://rivetedlit.com/wp-content/uploads/2020/01/all-this-time-9781534466340_xlg.jpg",
      "Book Three",
      "Author Three",
      "Description",
      "0.0",
      "Publisher",
      DateTime.now(),
    ),
    BookVO(
      "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/action-thriller-book-cover-design-template-3675ae3e3ac7ee095fc793ab61b812cc_screen.jpg?ts=1637008457",
      "Book Four",
      "Author Four",
      "Description",
      "0.0",
      "Publisher",
      DateTime.now(),
    ),
    BookVO(
      "https://marketplace.canva.com/EAD7WuSVrt0/1/0/1003w/canva-colorful-illustration-young-adult-book-cover-LVthABb24ik.jpg",
      "Book Five",
      "Author Five",
      "Description",
      "0.0",
      "Publisher",
      DateTime.now(),
    ),
    BookVO(
      "https://www.skipprichard.com/wp-content/uploads/2019/12/9780525645580.jpg",
      "Book Six",
      "Author Six",
      "Description",
      "0.0",
      "Publisher",
      DateTime.now(),
    ),
    BookVO(
      "https://img.buzzfeed.com/buzzfeed-static/static/2020-12/22/20/asset/d501ee3b6aaa/sub-buzz-8285-1608667292-7.jpg?downsize=700%3A%2A&output-quality=auto&output-format=auto",
      "Book Seven",
      "Author Seven",
      "Description",
      "0.0",
      "Publisher",
      DateTime.now(),
    ),
    BookVO(
      "http://bukovero.com/wp-content/uploads/2016/07/Harry_Potter_and_the_Cursed_Child_Special_Rehearsal_Edition_Book_Cover.jpg",
      "Book Eight",
      "Author Eight",
      "Description",
      "0.0",
      "Publisher",
      DateTime.now(),
    ),
    BookVO(
      "https://edit.org/photos/images/cat/book-covers-big-2019101610.jpg-1300.jpg",
      "Book Nine",
      "Author Nine",
      "Description",
      "0.0",
      "Publisher",
      DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: SearchPlayBooksAppBarView(
            onSearchBoxTap: () {},
          ),
          preferredSize: const Size.fromHeight(SEARCH_APP_BAR_HEIGHT),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DefaultTabController(
                      length: tabLabels.length,
                      child: TabBar(
                        isScrollable: false,
                        indicatorWeight: MARGIN_SMALL,
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.grey,
                        labelPadding: const EdgeInsets.symmetric(
                          vertical: MARGIN_CARD_MEDIUM_2,
                        ),
                        indicatorSize: TabBarIndicatorSize.label,
                        onTap: (index) {
                          setState(() {
                            selectedTabIndex = index;
                          });
                        },
                        tabs: tabLabels.map((label) {
                          return Text(label);
                        }).toList(),
                      ),
                    ),
                    const Divider(
                      height: 0,
                      color: Colors.black12,
                      thickness: 1.5,
                    ),
                    Visibility(
                      visible: selectedTabIndex == 0,
                      child: YourBooksSectionView(
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
                        selectedSortFilter: selectedSortFilter,
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
                        sortByFilters: sortByFilters,
                        onGridBookTap: () => _navigateToBookDetails(context),
                        onListBookTap: () => _navigateToBookDetails(context),
                        onTapOverflow: () => _showMoreOptionsOnBook(context),
                        books: dummyBooks,
                        onViewByFilterTap: () {
                          _showViewByFilterBottomSheet(context);
                        },
                        onSortByFilterTap: () {
                          _showSortByFilterBottomSheet(context);
                        },
                        viewByFilters: viewByFilters,
                        selectedViewFilter: selectedViewFilter,
                      ),
                    ),
                    Visibility(
                      visible: selectedTabIndex == 1,
                      child: YourShelvesSectionView(
                        onShelfTap: () => _navigateToShelfDetailsPage(context),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Visibility(
                visible: selectedTabIndex == 1,
                child: CreateNewShelfButtonView(
                  onTap: () => _navigateToCreateNewShelfPage(context),
                ),
              ),
            )
          ],
        ),
      ),
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
        builder: (context) => BookDetailsPage(title: ''),
      ),
    );
  }

  void _navigateToCreateNewShelfPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateNewShelfPage(),
      ),
    );
  }

  void _navigateToShelfDetailsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ShelfDetailsPage(),
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
  }
}

class CreateNewShelfButtonView extends StatelessWidget {
  final Function onTap;

  CreateNewShelfButtonView({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CREATE_NEW_SHELF_BUTTON_HEIGHT,
      margin: const EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
      child: ElevatedButton.icon(
        onPressed: () => onTap(),
        icon: const Icon(Icons.edit_outlined),
        label: const Text(CREATE_NEW),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              MARGIN_XXLARGE,
            ),
          ),
        ),
      ),
    );
  }
}

class YourShelvesSectionView extends StatelessWidget {
  final Function onShelfTap;

  YourShelvesSectionView({required this.onShelfTap});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: MARGIN_LARGE),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        BookShelfView(
          onShelfTap: onShelfTap,
        ),
      ],
    );
  }
}

class YourBooksSectionView extends StatelessWidget {
  final List<BookFilterChipVO> chipsData;
  final Function onTapClearButton;
  final String selectedSortFilter;
  final String selectedViewFilter;
  final List<String> viewByFilters;
  final List<String> sortByFilters;
  final List<BookVO> books;
  final Function(String, bool) onTapChip;
  final Function onSortByFilterTap;
  final Function onViewByFilterTap;
  final Function onGridBookTap;
  final Function onListBookTap;
  final Function onTapOverflow;

  YourBooksSectionView({
    required this.chipsData,
    required this.onTapClearButton,
    required this.selectedSortFilter,
    required this.selectedViewFilter,
    required this.viewByFilters,
    required this.sortByFilters,
    required this.books,
    required this.onTapChip,
    required this.onSortByFilterTap,
    required this.onViewByFilterTap,
    required this.onGridBookTap,
    required this.onListBookTap,
    required this.onTapOverflow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: MARGIN_MEDIUM),
        BookFilterChipsView(
          chipsData: chipsData,
          onTapChip: onTapChip,
          onTapClearButton: onTapClearButton,
        ),
        BookGridAndListWithSortAndViewFiltersSectionView(
          selectedSortFilter: selectedSortFilter,
          selectedViewFilter: selectedViewFilter,
          viewByFilters: viewByFilters,
          sortByFilters: sortByFilters,
          books: books,
          onSortByFilterTap: onSortByFilterTap,
          onViewByFilterTap: onViewByFilterTap,
          onGridBookTap: onGridBookTap,
          onListBookTap: onListBookTap,
          onTapOverflow: onTapOverflow,
        ),
      ],
    );
  }
}
