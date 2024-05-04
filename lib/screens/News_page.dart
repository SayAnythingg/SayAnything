import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFDECFE2), Color(0xFF7EC4CF)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('News'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
              height: 200.0, // Fixed height
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start, // Align the logo and the text at the top
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 1.0), // Decrease the space at the top of the logo
                    child: Image.asset('assets/images/logo.png', width: 50.0, height: 50.0), // Adjust the size of your logo
                  ),
                  SizedBox(width: 10.0), // Add some space between the logo and the text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('究竟是發生什麼事？', style: TextStyle(fontSize: 12.0)), // Adjust the font size of your title
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('2024/5/4', style: TextStyle(fontSize: 10.0)), // Adjust the font size of your time
                        ),
                        SizedBox(height: 10.0), // Add some space between the title/time and the content
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text('這是一個關於三個人的故事...待續這是一個關於三個人的故事...待續這是一個關於三個人的故事...待續這是一個關於三個人的故事...待續這是一個關於三個人的故事...待續這是一個關於三個人的故事...待續這是一個關於三個人的故事...待續這是一個關於三個人的故事...待續這是一個關於三個人的故事...待續這是一個關於三個人的故事...待續這是一個關於三個人的故事...待續這是一個關於三個人的故事...待續這是一個關於三個人的故事...待續這是一個關於三個人的故事...待續', style: TextStyle(fontSize: 12.0)), // Replace with your content
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}