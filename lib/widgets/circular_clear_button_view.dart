import 'package:flutter/material.dart';
import 'package:the_library_app/resources/dimens.dart';

class CircularClearButtonView extends StatelessWidget {
  const CircularClearButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CHIP_SELECTION_CLEAR_BUTTON_SIZE,
      height: CHIP_SELECTION_CLEAR_BUTTON_SIZE,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            CHIP_SELECTION_CLEAR_BUTTON_SIZE / 2,
          ),
          border: Border.all(
            color: Colors.black26,
          )),
      child: const Center(
        child: Icon(
          Icons.clear,
          color: Colors.black54,
          size: CLEAR_BUTTON_ICON_SIZE,
        ),
      ),
    );
  }
}