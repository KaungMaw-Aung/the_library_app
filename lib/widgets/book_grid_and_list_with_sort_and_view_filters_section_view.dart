import 'package:flutter/material.dart';
import 'package:the_library_app/data/vos/book_vo.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_grid_item_view.dart';
import 'package:the_library_app/view_items/book_list_item_view.dart';
import 'package:the_library_app/widgets/sort_by_and_view_by_filter_buttons_view.dart';

class BookGridAndListWithSortAndViewFiltersSectionView extends StatelessWidget {
  BookGridAndListWithSortAndViewFiltersSectionView({
    required this.selectedSortFilter,
    required this.selectedViewFilter,
    required this.viewByFilters,
    required this.sortByFilters,
    required this.books,
    required this.onSortByFilterTap,
    required this.onViewByFilterTap,
    required this.onGridBookTap,
    required this.onListBookTap,
    required this.onTapOverflow,
  });

  final String selectedSortFilter;
  final String selectedViewFilter;
  final List<String> viewByFilters;
  final List<String> sortByFilters;
  final List<BookVO>? books;
  final Function onSortByFilterTap;
  final Function onViewByFilterTap;
  final Function(String) onGridBookTap;
  final Function(String) onListBookTap;
  final Function(BookVO?) onTapOverflow;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SortByAndViewByFilterButtonsView(
          selectedSortFilter: selectedSortFilter,
          selectedViewFilter: selectedViewFilter,
          onSortByFilterTap: onSortByFilterTap,
          onViewByFilterTap: onViewByFilterTap,
        ),
        selectedViewFilter == viewByFilters.last
            ? ListView.builder(
                key: const Key('view by list'),
                itemCount: books?.length ?? 0,
                padding: const EdgeInsets.only(top: MARGIN_MEDIUM_2),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return BookListItemView(
                    book: books?[index],
                    onBookTap: onListBookTap,
                    onTapOverflow: onTapOverflow,
                  );
                },
              )
            : GridView.builder(
                key: const Key('view by grid'),
                padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
                itemCount: books?.length ?? 0,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      selectedViewFilter == viewByFilters.first ? 3 : 2,
                  childAspectRatio: 1 / 2,
                  mainAxisSpacing: MARGIN_MEDIUM_2,
                  crossAxisSpacing: MARGIN_MEDIUM_2,
                ),
                itemBuilder: (context, index) {
                  return BookGridItemView(
                    key: Key(books?[index].title ?? ""),
                    book: books?[index],
                    gridCount:
                        selectedViewFilter == viewByFilters.first ? 3 : 2,
                    onBookTap: onGridBookTap,
                    onOverflowTap: onTapOverflow,
                  );
                },
              ),
      ],
    );
  }
}
