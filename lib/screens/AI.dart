import 'package:flutter/material.dart';

class multimedia extends StatefulWidget {
  @override
  _AIState createState() => _AIState();
}

class _AIState extends State<multimedia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.psychology_rounded, size: 30, color: Color(0xFF545454)),
            SizedBox(width: 4),
            Image.asset('assets/images/MultiMedia3.png', height: 135, width: 135),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFDECFE2),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFDECFE2), Color(0xFF7EC4CF)],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20), // Add this line
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}