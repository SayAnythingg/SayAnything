import 'package:flutter/material.dart';
import 'package:SayAnything/services/API_services.dart';

final JokeApiService = JokeApi();

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
        actions: <Widget>[ 
         IconButton(
            icon: Icon(Icons.smart_toy_outlined, color: Color(0xFF545454),),
            onPressed: () async {
              final joke = await JokeApiService.getJoke(1); 
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    content: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Image.asset('assets/images/logo.png', width: 50.0, height: 50.0),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(height: 60),
                            Text(
                              joke.setup,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Text(
                              joke.punchline,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.api),
            onPressed: () {
             
            },
          ),
          IconButton(
            icon: Icon(Icons.api),
            onPressed: () {
              
            },
          ),
        ],
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
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), 
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}