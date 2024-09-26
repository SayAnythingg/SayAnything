import 'dart:io';

import 'package:say_anything/screens/Main_page.dart';
import 'package:say_anything/services/Model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:say_anything/controllers/PrivacyPolicyPageController.dart';
class PrivacyPolicyPage extends StatefulWidget {
  final User user;

  const PrivacyPolicyPage({super.key, required this.user});

  @override
  // ignore: library_private_types_in_public_api
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final PrivacyPolicyPageController _controller = PrivacyPolicyPageController();

  @override
  void initState() {
    super.initState();
    _controller.downloadFile().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.failedToLoad) {
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
          _controller.pdfFilePath != null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: SfPdfViewer.file(
                    File(_controller.pdfFilePath!),
                    onPageChanged: (PdfPageChangedDetails details) {
                      setState(() {
                        _controller.onPageChanged(details.newPageNumber);
                      });
                    },
                    onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                      setState(() {
                        _controller.onDocumentLoaded(details.document.pages.count);
                      });
                    },
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 16.0,
            left: 0.0,
            right: 0.0,
            child: _controller.agreed
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