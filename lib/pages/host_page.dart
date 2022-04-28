import 'package:flutter/material.dart';
import 'package:the_library_app/resources/strings.dart';

import 'home_page.dart';

class HostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
      bottomNavigationBar: BottomNavigationBar(
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
