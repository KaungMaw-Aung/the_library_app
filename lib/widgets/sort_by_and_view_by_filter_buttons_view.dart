import 'package:flutter/material.dart';
import 'package:the_library_app/resources/dimens.dart';

class SortByAndViewByFilterButtonsView extends StatelessWidget {
  SortByAndViewByFilterButtonsView({
    required this.selectedSortFilter,
    required this.selectedViewFilter,
    required this.onSortByFilterTap,
    required this.onViewByFilterTap,
  });

  final String selectedSortFilter;
  final String selectedViewFilter;
  final Function onSortByFilterTap;
  final Function onViewByFilterTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: MARGIN_MEDIUM),
        TextButton.icon(
          onPressed: () {
            onSortByFilterTap();
          },
          icon: const Icon(
            Icons.sort,
            color: Colors.black54,
          ),
          label: Text(
            "Sort by: $selectedSortFilter",
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
        const Spacer(),
        TextButton.icon(
          onPressed: () {
            onViewByFilterTap();
          },
          icon: const Icon(
            Icons.view_list_outlined,
            color: Colors.black54,
          ),
          label: Text(
            "View: $selectedViewFilter",
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
        const SizedBox(width: MARGIN_MEDIUM_2),
      ],
    );
  }
}