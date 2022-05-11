import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:the_library_app/data/vos/book_filter_chip_vo.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/dimens.dart';

import 'circular_clear_button_view.dart';

class BookFilterChipsView extends StatelessWidget {
  final List<BookFilterChipVO> chipsData;
  final Function onTapClearButton;
  final Function(String, bool) onTapChip;

  BookFilterChipsView({
    required this.chipsData,
    required this.onTapClearButton,
    required this.onTapChip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: LIBRARY_HORIZONTAL_CHIP_LIST_HEIGHT,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(width: MARGIN_MEDIUM_2),
            Visibility(
              visible: chipsData
                  .map((element) => element.isSelected)
                  .toList()
                  .contains(true),
              child: InkWell(
                onTap: () => onTapClearButton(),
                borderRadius: BorderRadius.circular(
                  CHIP_SELECTION_CLEAR_BUTTON_SIZE / 2,
                ),
                child: const CircularClearButtonView(),
              ),
            ),
            const SizedBox(width: MARGIN_MEDIUM),
            /* ...chipsData.map(
                  (chipData) {
                return Row(
                  children: [
                    FilterChip(
                      label: Text(chipData.label),
                      labelStyle: TextStyle(
                        color:
                        chipData.isSelected ? Colors.white : Colors.black,
                      ),
                      backgroundColor: Colors.white,
                      selectedColor: FILTER_CHIP_SELECTED_BG_COLOR,
                      showCheckmark: false,
                      selected: chipData.isSelected,
                      side: chipData.isSelected
                          ? null
                          : const BorderSide(color: Colors.black12),
                      onSelected: (isSelected) {
                        onTapChip(chipData.label, isSelected);
                      },
                    ),
                    const SizedBox(width: MARGIN_MEDIUM),
                  ],
                );
              },
            ).toList(),*/
            ...chipsData
                .where((element) => element.isSelected == true)
                .map(
              (chipData) {
                return Row(
                  children: [
                    FilterChip(
                      label: Text(chipData.label),
                      labelStyle: TextStyle(
                        color:
                            chipData.isSelected ? Colors.white : Colors.black,
                      ),
                      backgroundColor: Colors.white,
                      selectedColor: FILTER_CHIP_SELECTED_BG_COLOR,
                      showCheckmark: false,
                      selected: chipData.isSelected,
                      side: chipData.isSelected
                          ? null
                          : const BorderSide(color: Colors.black12),
                      onSelected: (isSelected) {
                        onTapChip(chipData.label, isSelected);
                      },
                    ),
                    const SizedBox(width: MARGIN_MEDIUM),
                  ],
                );
              },
            ).toList(),
            ...chipsData
                .where((element) => element.isSelected == false)
                .map(
                  (chipData) {
                return Row(
                  children: [
                    FilterChip(
                      label: Text(chipData.label),
                      labelStyle: TextStyle(
                        color:
                        chipData.isSelected ? Colors.white : Colors.black,
                      ),
                      backgroundColor: Colors.white,
                      selectedColor: FILTER_CHIP_SELECTED_BG_COLOR,
                      showCheckmark: false,
                      selected: chipData.isSelected,
                      side: chipData.isSelected
                          ? null
                          : const BorderSide(color: Colors.black12),
                      onSelected: (isSelected) {
                        onTapChip(chipData.label, isSelected);
                      },
                    ),
                    const SizedBox(width: MARGIN_MEDIUM),
                  ],
                );
              },
            ).toList()
          ],
        ),
      ),
    );
  }
}
