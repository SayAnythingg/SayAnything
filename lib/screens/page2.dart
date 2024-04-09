import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipPath(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFDECFE2), Color(0xFF7EC4CF)],
            ),
          ),
          child: Column(
            children: [
              AppBar(
                title: Text('AI Chat'),
                backgroundColor: Colors.transparent, 
                elevation: 0, 
                automaticallyImplyLeading: false,
              ),
              Center(
              
              ),
            ],
          ),
        ),
      ),
    );
  }
}