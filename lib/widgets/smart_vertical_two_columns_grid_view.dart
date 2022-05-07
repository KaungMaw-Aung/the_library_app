import 'package:flutter/material.dart';

class SmartVerticalTwoColumnsGridView extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsets padding;
  final Function onListEndReached;

  SmartVerticalTwoColumnsGridView({
    required this.itemCount,
    required this.itemBuilder,
    required this.padding,
    required this.onListEndReached,
  });

  @override
  State<SmartVerticalTwoColumnsGridView> createState() => _SmartVerticalTwoColumnsGridViewState();
}

class _SmartVerticalTwoColumnsGridViewState extends State<SmartVerticalTwoColumnsGridView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          print("Start of the list reached");
        } else {
          print("End of the list reached");
          widget.onListEndReached();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == 0) {
      return const Center(
        child: Text(
          "Load some data with network connection",
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return GridView.builder(
        controller: _scrollController,
        padding: widget.padding,
        itemCount: widget.itemCount,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.8,
        ),
        itemBuilder: widget.itemBuilder,
      );
    }
  }
}
