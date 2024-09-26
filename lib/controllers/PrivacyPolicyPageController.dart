import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class PrivacyPolicyPageController {
  bool _agreed = false;
  String? pdfPath;
  int _totalPages = 0;
  int _currentPage = 0;
  bool _failedToLoad = false;

  bool get agreed => _agreed;
  String? get pdfFilePath => pdfPath;
  int get totalPages => _totalPages;
  int get currentPage => _currentPage;
  bool get failedToLoad => _failedToLoad;

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
    }
  }

  void onPageChanged(int newPageNumber) {
    _currentPage = newPageNumber;
    _agreed = _currentPage == _totalPages;
  }

  void onDocumentLoaded(int pageCount) {
    _totalPages = pageCount;
  }
}
