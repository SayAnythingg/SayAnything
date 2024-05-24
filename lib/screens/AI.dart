import 'package:flutter/material.dart';

class multimedia extends StatefulWidget {
  @override
  _AIState createState() => _AIState();
}

class _AIState extends State<multimedia> {
  final List<String> models1 = ['Model 1', 'Model 2', 'Model 3', 'Model 4'];
  final List<String> models2 = ['Model A', 'Model B', 'Model C', 'Model D'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Column(
              children: [
                AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      Icon(Icons.psychology_rounded, size: 40), 
                      SizedBox(width: 4), 
                      Image.asset('assets/images/multiMedia.png', height: 145, width: 145), 
                    ],
                  ),
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      _buildSectionTitle('正在苦惱與同學沒有話題嗎？'),
                      _buildCardSection(models1),
                      _buildSectionTitle('正在苦惱沒地方學習嗎？'),
                      _buildCardSection(models2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCardSection(List<String> models) {
    return Container(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: models.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              child: InkWell(
                onTap: () {
                  print('Tapped on Model: ${models[index]}');
                },
                child: Container(
                  width: 160.0,
                  child: Center(
                    child: Text(
                      models[index],
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}