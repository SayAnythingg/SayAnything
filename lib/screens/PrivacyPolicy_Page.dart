import 'package:SayAnything/screens/Main_page.dart';
import 'package:SayAnything/services/Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class PrivacyPolicyPage extends StatefulWidget {
  final User user;

  PrivacyPolicyPage({required this.user});

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  bool _agreed = false;
  String? pdfPath;
  int _totalPages = 0;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    downloadFile();
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(
          'https://drive.google.com/uc?export=download&id=1tCVd2Y_83El09nBis-7gMxLzgMLmOBC-',
          '${dir.path}/privacy_policy.pdf');
      pdfPath = '${dir.path}/privacy_policy.pdf';
      setState(() {});
    } catch (e) {
      print('Download error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,  // 隱藏返回按鈕
        title: Text('Privacy Policy'),
      ),
      body: Stack(
        children: [
          pdfPath != null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: PDFView(
                    filePath: pdfPath!,
                    enableSwipe: true,
                    swipeHorizontal: false,
                    autoSpacing: false,
                    pageFling: false,
                    fitPolicy: FitPolicy.BOTH,
                    onRender: (_pages) {
                      setState(() {
                        _totalPages = _pages!;
                      });
                    },
                    onPageChanged: (int? page, int? total) {
                      setState(() {
                        _currentPage = page ?? 0;
                        _agreed = _currentPage == (_totalPages - 1);
                      });
                    },
                  ),
                )
              : Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 16.0,
            left: 0.0,
            right: 0.0,
            child: _agreed
                ? FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(initialIndex: 1, user: widget.user),
                        ),
                      );
                    },
                    icon: Icon(Icons.check),
                    label: Text('我已閱讀並確認'),
                    backgroundColor: Color(0xFF7EC4CF),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}