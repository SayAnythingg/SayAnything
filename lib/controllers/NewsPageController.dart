import 'package:flutter/material.dart';
import 'package:say_anything/services/API_services.dart';
import 'package:say_anything/services/Model.dart';

class NewsPageController {
  final Future<List<News>> futureNews = NewsApiService().getAllNews();
  final ScrollController scrollController = ScrollController();

  final List<News> defaultNews = [
    News(
        id: '0',
        title: '歡迎進入最佳世界',
        content: '歡迎加入這個大家庭',
        createdTime: '2024-01-01 09:00:00'),
  ];

  void dispose() {
    scrollController.dispose();
  }
}