import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/library_bloc.dart';
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

class LibraryPage extends StatelessWidget {
  final List<String> tabLabels = [YOUR_BOOKS_TAB_LABEL, YOUR_SHELVES_TAB_LABEL];
  final List<String> sortByFilters = ["Author", "Recent", "Title"];
  final List<String> viewByFilters = ["Grid 3x", "Grid 2x", "List"];

  /// State Variables
  int? groupValue = 1;
  int? viewFilterGroupValue = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LibraryBloc(),
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            child: SearchPlayBooksAppBarView(
              onSearchBoxTap: () {},
            ),
            preferredSize: const Size.fromHeight(SEARCH_APP_BAR_HEIGHT),
          ),
          body: Selector<LibraryBloc, int>(
            selector: (context, bloc) => bloc.selectedTabIndex,
            builder: (context, selectedTabIndex, child) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Builder(
                            builder: (context) {
                              return DefaultTabController(
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
                                    LibraryBloc bloc =
                                        Provider.of(context, listen: false);
                                    bloc.onTapTab(index);
                                  },
                                  tabs: tabLabels.map((label) {
                                    return Text(label);
                                  }).toList(),
                                ),
                              );
                            },
                          ),
                          const Divider(
                            height: 0,
                            color: Colors.black12,
                            thickness: 1.5,
                          ),
                          Visibility(
                            visible: selectedTabIndex == 0,
                            child: Consumer<LibraryBloc>(
                              builder: (context, bloc, child) {
                                return bloc.myBooks != null
                                    ? YourBooksSectionView(
                                        chipsData: bloc.chipsData ?? [],
                                        onTapChip: (label, isSelected) {
                                          LibraryBloc bloc = Provider.of(
                                              context,
                                              listen: false);
                                          bloc.onTapChip(label, isSelected);
                                        },
                                        selectedSortFilter:
                                            bloc.selectedSortFilter,
                                        selectedViewFilter:
                                            bloc.selectedViewFilter,
                                        onTapClearButton: () {
                                          LibraryBloc bloc = Provider.of(
                                              context,
                                              listen: false);
                                          bloc.onTapClearButton();
                                        },
                                        books: bloc.myBooks,
                                        sortByFilters: sortByFilters,
                                        viewByFilters: viewByFilters,
                                        onGridBookTap: (title) =>
                                            _navigateToBookDetails(
                                                context, title),
                                        onListBookTap: (title) =>
                                            _navigateToBookDetails(
                                                context, title),
                                        onTapOverflow: () =>
                                            _showMoreOptionsOnBook(context),
                                        onViewByFilterTap: () {
                                          _showViewByFilterBottomSheet(context);
                                        },
                                        onSortByFilterTap: () {
                                          _showSortByFilterBottomSheet(context);
                                        },
                                      )
                                    : const Text(
                                        YOUR_LIBRARY_IS_EMPTY,
                                      );
                              },
                            ),
                          ),
                          Visibility(
                            visible: selectedTabIndex == 1,
                            child: YourShelvesSectionView(
                              onShelfTap: () =>
                                  _navigateToShelfDetailsPage(context),
                            ),
                          ),
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
              );
            },
          ),
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

  void _navigateToBookDetails(BuildContext context, String bookTitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsPage(title: bookTitle),
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

  void _showSortByFilterBottomSheet(BuildContext buildContext) {
    showModalBottomSheet(
      context: buildContext,
      builder: (context) {
        LibraryBloc bloc = Provider.of(buildContext, listen: false);
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
                  bloc.onTapSortByFilter(sortByFilters.first);
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
                    bloc.onTapSortByFilter(sortByFilters.first);
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
                  bloc.onTapSortByFilter(sortByFilters[1]);
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
                    bloc.onTapSortByFilter(sortByFilters[1]);
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
                  bloc.onTapSortByFilter(sortByFilters.last);
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
                    bloc.onTapSortByFilter(sortByFilters.last);
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
        LibraryBloc bloc = Provider.of(buildContext, listen: false);
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
                  bloc.onTapViewByFilter(viewByFilters.first);
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
                    bloc.onTapViewByFilter(viewByFilters.first);
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
                  bloc.onTapViewByFilter(viewByFilters[1]);
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
                    bloc.onTapViewByFilter(viewByFilters[1]);
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
                  bloc.onTapViewByFilter(viewByFilters.last);
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
                    bloc.onTapViewByFilter(viewByFilters.last);
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
  final List<BookVO>? books;
  final Function(String, bool) onTapChip;
  final Function onSortByFilterTap;
  final Function onViewByFilterTap;
  final Function(String) onGridBookTap;
  final Function(String) onListBookTap;
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
