import 'package:crypto_tracker/pages/news_details.dart';
import 'package:crypto_tracker/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, newsProvider, child) {
        if (newsProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (newsProvider.news.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                newsProvider.fetchNews();
              },
              child: ListView.builder(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return NewsDetails(
                              news: newsProvider.news[index],
                            );
                          },
                        ));
                      },
                      title: Text(
                        newsProvider.news[index].title!,
                        style: const TextStyle(color: Colors.blue),
                      ),
                      subtitle: Text(newsProvider.news[index].description!),
                    ),
                  );
                },
                itemCount: newsProvider.news.length,
              ),
            );
          } else {
            return const Center(
              child: Text("Couldn't fetch latest news!!"),
            );
          }
        }
      },
    );
  }
}
