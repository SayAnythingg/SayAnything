import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:say_anything/services/Model.dart';
import 'package:say_anything/controllers/MainPageController.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;
  final User user;

  const MainPage({super.key, required this.initialIndex, required this.user});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MainPageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MainPageController(widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller.pageController,
        onPageChanged: (index) {
          setState(() {
            _controller.onItemTapped(index);
          });
        },
        children: _controller.getWidgetOptions(widget.user),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _controller.selectedIndex,
        height: 60.0,
        backgroundColor: const Color(0xFF7EC4CF),
        items: <Widget>[
          Icon(Icons.psychology_rounded, size: 30, color: _controller.iconColors[0]),
          Icon(Icons.home, size: 30, color: _controller.iconColors[1]),
          Icon(Icons.wechat, size: 30, color: _controller.iconColors[2]),
        ],
        onTap: (index) {
          setState(() {
            _controller.onItemTapped(index);
          });
          _controller.pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}