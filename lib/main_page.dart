import 'package:flutter/material.dart';
import 'home_page.dart';
import 'save_page.dart';

class MainPage extends StatefulWidget {
  static String tag = 'main-page';

  @override
  State<StatefulWidget> createState() {
    return new _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  PageController pageController;
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new PageView(children: [
          new HomePage(),
          new ReadWritePage(storage: DataStorage()),
        ], controller: pageController, onPageChanged: onPageChanged),
        bottomNavigationBar: new BottomNavigationBar(items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.calendar_today),
            title: new Text("Home"),
          ),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.input), title: new Text("Save/Load")),
          /* new BottomNavigationBarItem(
              icon: new Icon(Icons.laptop_windows), title: new Text("Load")) */
        ], onTap: onTap, currentIndex: page));
  }

  @override
  void initState() {
    super.initState();
    pageController = new PageController(initialPage: this.page);
  }

  void onTap(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }
}
