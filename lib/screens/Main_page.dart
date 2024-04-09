import 'package:SayAnything/screens/chatList_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:SayAnything/screens/page2.dart';
import 'package:SayAnything/screens/home.dart';
import 'package:SayAnything/services/Model.dart';


class MainPage extends StatefulWidget {
  final int initialIndex;

  MainPage({Key? key, this.initialIndex = 0}) : super(key: key) {
  assert(0 <= initialIndex && initialIndex < 4, 'initialIndex must be between 0 and 3.');
}

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PageController _pageController = PageController(initialPage: widget.initialIndex);
  User user = User(name: 'John Doe', gender: 'Female', email: 'johndoe@example.com', password: 'password123', userId: '1234567890');
  int _selectedIndex = 0;

  List<Widget> get _widgetOptions {
    return <Widget>[
      Page2(),
      HomePage(user: user),
      ChatList(),
    ];
  }

  List<Color> _iconColors = List.generate(4, (index) => Color(0xFFDECFE2));

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    Future.delayed(Duration.zero, () {
      setState(() {
        _selectedIndex = widget.initialIndex;
        _iconColors[_selectedIndex] = Color(0xFF7EC4CF);  
      });
    });
  }

  void _onItemTapped(int index) {
  setState(() {
    _iconColors[_selectedIndex] = Color(0xFFDECFE2);  
    _selectedIndex = index;
    _iconColors[_selectedIndex] = Color(0xFF7EC4CF);  
  });
  _pageController.animateToPage(
    index,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _iconColors[_selectedIndex] = Color(0xFFDECFE2);  
            _selectedIndex = index;
            _iconColors[_selectedIndex] = Color(0xFF7EC4CF);  
          });
        },
        children: _widgetOptions,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 60.0,
        backgroundColor: Color(0xFF7EC4CF),
        items: <Widget>[
          Icon(Icons.people, size: 30, color: _iconColors[0]),
          Icon(Icons.home, size: 30, color: _iconColors[1]),
          Icon(Icons.wechat, size: 30, color: _iconColors[2]),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}