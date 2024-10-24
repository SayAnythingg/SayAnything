import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) {
            if (kDebugMode) {
              print('Allowing certificate: $cert from $host:$port');
            }
            return true; 
          };
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();

  group('HttpOverrides Tests', () {
    test('Test invalid certificate request', () async {
  HttpClient client = HttpClient();
      final response = await client
      .getUrl(Uri.parse('https://self-signed.badssl.com/'))
          .then((HttpClientRequest request) => request.close());

      expect(response.statusCode, 200);
      response.transform(const SystemEncoding().decoder).listen((data) {
        if (kDebugMode) {
          print(data);
        }
      });
    });

    test('Test valid certificate request', () async {
      HttpClient client = HttpClient();
      final response = await client
          .getUrl(Uri.parse('https://www.google.com'))
          .then((HttpClientRequest request) => request.close());

      expect(response.statusCode, 200);
      response.transform(const SystemEncoding().decoder).listen((data) {
        if (kDebugMode) {
          print(data);
        }
      });
    });

    test('Test invalid URL', () async {
      HttpClient client = HttpClient();
      try {
        await client
            .getUrl(Uri.parse('https://invalid.url'))
            .then((HttpClientRequest request) => request.close());
        fail('Expected an exception to be thrown');
      } catch (e) {
        expect(e, isA<SocketException>());
      }
    });
  });
}
