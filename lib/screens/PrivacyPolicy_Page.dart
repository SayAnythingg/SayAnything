import 'dart:io';

import 'package:say_anything/screens/Main_page.dart';
import 'package:say_anything/services/Model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class PrivacyPolicyPage extends StatefulWidget {
  final User user;

  const PrivacyPolicyPage({super.key, required this.user});

  @override
  // ignore: library_private_types_in_public_api
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  bool _agreed = false;
  String? pdfPath;
  int _totalPages = 0;
  int _currentPage = 0;
  bool _failedToLoad = false;

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
    } catch (e) {
      if (kDebugMode) {
        print('Download error: $e');
      }
      _failedToLoad = true;
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_failedToLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainPage(initialIndex: 1, user: widget.user),
          ),
        );
      });
    }

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            const Text('Privacy Policy', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF7EC4CF),
      ),
      body: Stack(
        children: [
          pdfPath != null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: SfPdfViewer.file(
                    File(pdfPath!),
                    onPageChanged: (PdfPageChangedDetails details) {
                      setState(() {
                        _currentPage = details.newPageNumber;
                        _agreed = _currentPage == _totalPages;
                      });
                    },
                    onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                      setState(() {
                        _totalPages = details.document.pages.count;
                      });
                    },
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
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
                          builder: (context) =>
                              MainPage(initialIndex: 1, user: widget.user),
                        ),
                      );
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('我已閱讀並確認'),
                    backgroundColor: const Color(0xFF7EC4CF),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
