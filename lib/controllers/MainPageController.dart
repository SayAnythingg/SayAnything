import 'package:flutter/material.dart';
import 'package:say_anything/services/Model.dart';
import 'package:say_anything/screens/chatList_page.dart';
import 'package:say_anything/screens/AI.dart';
import 'package:say_anything/screens/home.dart';

class MainPageController {
  late PageController pageController;
  int selectedIndex = 0;
  final List<Color> iconColors = List.generate(4, (index) => const Color(0xFFDECFE2));

  MainPageController(int initialIndex) {
    pageController = PageController(initialPage: initialIndex);
    selectedIndex = initialIndex;
    iconColors[selectedIndex] = const Color(0xFF7EC4CF);
  }

  List<Widget> getWidgetOptions(User user) {
    return <Widget>[
      const Multimedia(),
      HomePage(user: user),
      const ChatList(),
    ];
  }

  void onItemTapped(int index) {
    iconColors[selectedIndex] = const Color(0xFFDECFE2);
    selectedIndex = index;
    iconColors[selectedIndex] = const Color(0xFF7EC4CF);
  }

  void dispose() {
    pageController.dispose();
  }
}