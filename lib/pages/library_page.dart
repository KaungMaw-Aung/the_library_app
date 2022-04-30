import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:the_library_app/data/vos/book_filter_chip_vo.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/pages/create_new_shelf_page.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';
import 'package:the_library_app/view_items/book_grid_item_view.dart';
import 'package:the_library_app/view_items/book_list_item_view.dart';
import 'package:the_library_app/view_items/book_shelf_view.dart';
import 'package:the_library_app/widgets/book_filter_chips_view.dart';
import 'package:the_library_app/widgets/book_grid_and_list_with_sort_and_view_filters_section_view.dart';
import 'package:the_library_app/widgets/search_play_books_app_bar_view.dart';

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
      1,
    ),
    BookVO(
      "https://www.theyoungfolks.com/wp-content/uploads/2017/08/six-of-crows-770x1156.jpg",
      "Book Two",
      "Author Two",
      2,
    ),
    BookVO(
      "https://rivetedlit.com/wp-content/uploads/2020/01/all-this-time-9781534466340_xlg.jpg",
      "Book Three",
      "Author Three",
      3,
    ),
    BookVO(
      "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/action-thriller-book-cover-design-template-3675ae3e3ac7ee095fc793ab61b812cc_screen.jpg?ts=1637008457",
      "Book Four",
      "Author Four",
      4,
    ),
    BookVO(
      "https://marketplace.canva.com/EAD7WuSVrt0/1/0/1003w/canva-colorful-illustration-young-adult-book-cover-LVthABb24ik.jpg",
      "Book Five",
      "Author Five",
      5,
    ),
    BookVO(
      "https://www.skipprichard.com/wp-content/uploads/2019/12/9780525645580.jpg",
      "Book Six",
      "Author Six",
      6,
    ),
    BookVO(
      "https://img.buzzfeed.com/buzzfeed-static/static/2020-12/22/20/asset/d501ee3b6aaa/sub-buzz-8285-1608667292-7.jpg?downsize=700%3A%2A&output-quality=auto&output-format=auto",
      "Book Seven",
      "Author Seven",
      7,
    ),
    BookVO(
      "http://bukovero.com/wp-content/uploads/2016/07/Harry_Potter_and_the_Cursed_Child_Special_Rehearsal_Edition_Book_Cover.jpg",
      "Book Eight",
      "Author Eight",
      8,
    ),
    BookVO(
      "https://edit.org/photos/images/cat/book-covers-big-2019101610.jpg-1300.jpg",
      "Book Nine",
      "Author Nine",
      9,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: SearchPlayBooksAppBarView(),
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
                      child: Column(
                        children: [
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
                            onSortByFilterTap: () {
                              _showSortByFilterBottomSheet(context);
                            },
                            onViewByFilterTap: () {
                              _showViewByFilterBottomSheet(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: selectedTabIndex == 1,
                      child: ListView(
                        padding: const EdgeInsets.only(top: MARGIN_LARGE),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: const [
                          BookShelfView(),
                        ],
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
                child: Container(
                  height: CREATE_NEW_SHELF_BUTTON_HEIGHT,
                  margin: const EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _navigateToCreateNewShelfPage(context);
                    },
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
                ),
              ),
            )
          ],
        ),
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

  void _showSortByFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (context, setModalState) {
              return Wrap(
                children: [
                  const ListTile(
                    title: Text(SORT_BY),
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
                        selectedSortFilter =
                            sortByFilters.first;
                        dummyBooks.sort((first, second) {
                          return first.author.codeUnits
                              .reduce(
                                (value, element) =>
                            value + element,
                          )
                              .compareTo(
                            second.author.codeUnits
                                .reduce(
                                  (value, element) =>
                              value + element,
                            ),
                          );
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
                          selectedSortFilter =
                              sortByFilters.first;
                          dummyBooks.sort((first, second) {
                            return first.author.codeUnits
                                .reduce(
                                  (value, element) =>
                              value + element,
                            )
                                .compareTo(
                              second.author.codeUnits
                                  .reduce(
                                    (value, element) =>
                                value + element,
                              ),
                            );
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
                        selectedSortFilter =
                        sortByFilters[1];
                        dummyBooks.sort((first, second) {
                          return first.createdAt?.compareTo(
                              second.createdAt ?? 0) ??
                              0;
                        });
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
                          selectedSortFilter =
                          sortByFilters[1];
                          dummyBooks.sort((first, second) {
                            return first.createdAt
                                ?.compareTo(
                                second.createdAt ??
                                    0) ??
                                0;
                          });
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
                        selectedSortFilter =
                            sortByFilters.last;
                        dummyBooks.sort((first, second) {
                          return first.title.codeUnits
                              .reduce(
                                (value, element) =>
                            value + element,
                          )
                              .compareTo(
                            second.title.codeUnits
                                .reduce(
                                  (value, element) =>
                              value + element,
                            ),
                          );
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
                          selectedSortFilter =
                              sortByFilters.last;
                          dummyBooks.sort((first, second) {
                            return first.title.codeUnits
                                .reduce(
                                  (value, element) =>
                              value + element,
                            )
                                .compareTo(
                              second.title.codeUnits
                                  .reduce(
                                    (value, element) =>
                                value + element,
                              ),
                            );
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
        return StatefulBuilder(
            builder: (context, setModalState) {
              return Wrap(
                children: [
                  const ListTile(
                    title: Text(VIEW_BY),
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
                        selectedViewFilter =
                            viewByFilters.first;
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
                          selectedViewFilter =
                              viewByFilters.first;
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
                        selectedViewFilter =
                        viewByFilters[1];
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
                          selectedViewFilter =
                          viewByFilters[1];
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
                        selectedViewFilter =
                            viewByFilters.last;
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
                          selectedViewFilter =
                              viewByFilters.last;
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








