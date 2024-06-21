// ignore: file_names
import 'package:SayAnything/widgets/wait.dart';
import 'package:SayAnything/services/API_services.dart';
import 'package:SayAnything/services/Model.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final Future<List<News>> futureNews = NewsApiService().getAllNews();
  final ScrollController _scrollController = ScrollController();

  final List<News> defaultNews = [
    News(
        id: '0',
        title: '歡迎進入最佳世界',
        content: '歡迎加入這個大家庭',
        createdTime: ' 2024-01-01 09:00:00'),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<News>>(
      future: futureNews,
      builder: (context, snapshot) {
        List<News> newsList;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return WaitPage();
        } else if (snapshot.hasError) {
          newsList = defaultNews;
        } else {
          newsList = snapshot.data!;
        }

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFDECFE2), Color(0xFF7EC4CF)],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text('News'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Scrollbar(
              controller: _scrollController,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  News news = newsList[index];
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 200.0,
                    margin: const EdgeInsets.all(20.0),
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child: Image.asset('assets/images/logo.png',
                              width: 50.0, height: 50.0),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(news.title,
                                    style: const TextStyle(fontSize: 12.0)),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(news.createdTime,
                                    style: const TextStyle(fontSize: 10.0)),
                              ),
                              const SizedBox(height: 10.0),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(news.content,
                                      style: const TextStyle(fontSize: 12.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
