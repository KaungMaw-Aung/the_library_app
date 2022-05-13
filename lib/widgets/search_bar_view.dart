import 'package:flutter/material.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/resources/strings.dart';

class SearchBarView extends StatefulWidget {
  final Function(String) onSearchTextChanged;
  final Function(String) onSubmit;
  final bool autoFocus;
  final bool enabled;
  final String preLoadText;
  final Function onTapBack;

  SearchBarView({
    required this.onSearchTextChanged,
    required this.onSubmit,
    required this.onTapBack,
    this.autoFocus = true,
    this.enabled = true,
    this.preLoadText = "",
  });

  @override
  State<SearchBarView> createState() => _SearchBarViewState();
}

class _SearchBarViewState extends State<SearchBarView> {
  var textController = TextEditingController();

  @override
  void initState() {
    textController.text = widget.preLoadText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: MARGIN_MEDIUM_2),
            GestureDetector(
              key: const Key("back"),
              onTap: () => widget.onTapBack(),
              child: const Icon(Icons.arrow_back),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                child: TextField(
                  onChanged: (typedText) =>
                      widget.onSearchTextChanged(typedText),
                  onSubmitted: (searchText) => widget.onSubmit(searchText),
                  autofocus: widget.autoFocus,
                  enabled: widget.enabled,
                  controller: textController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: SEARCH_PLAY_BOOKS,
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
            ),
            const Icon(Icons.mic_rounded),
            const SizedBox(width: MARGIN_MEDIUM_2),
          ],
        ),
      ],
    );
  }
}
