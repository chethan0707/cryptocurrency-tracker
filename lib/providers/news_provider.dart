import 'package:crypto_tracker/models/news.dart';
import 'package:flutter/foundation.dart';

import '../models/api.dart';

class NewsProvider with ChangeNotifier {
  bool isLoading = true;
  List<News> news = [];

  NewsProvider() {
    fetchNews();
  }

  Future<void> fetchNews() async {
    List<dynamic> response = await API.getNews();

    List<News> tempNews = [];
    for (var newsItem in response) {
      News _news = News.fromJson(newsItem);
      tempNews.add(_news);
    }

    news = tempNews;
    isLoading = false;
    notifyListeners();
  }

  fetchNewsById() {}
}
