import 'package:flutter/material.dart';
import 'package:the_library_app/pages/library_page.dart';
import 'package:the_library_app/resources/strings.dart';

import 'home_page.dart';

class HostPage extends StatefulWidget {

  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  final List<Widget> mainPages = [HomePage(), LibraryPage()];
  int currentBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentBottomNavIndex == 0 ? mainPages.first : mainPages.last,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentBottomNavIndex,
        onTap: (index) {
          setState(() {
            currentBottomNavIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: BOTTOM_NAV_HOME_LABEL,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            label: BOTTOM_NAV_LIBRARY_LABEL,
          )
        ],
      ),
    );
  }
}
