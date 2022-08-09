import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/news.dart';

class NewsDetails extends StatelessWidget {
  final News news;
  const NewsDetails({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                news.imageUrl == null
                    ? Center(
                        child: SvgPicture.asset(
                          "lib/assets/crypto.svg",
                          height: 200,
                          fit: BoxFit.fill,
                        ),
                      )
                    : Image.network(
                        news.imageUrl!,
                      ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  news.title!,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  height: 5,
                  color: Colors.grey,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      news.description!,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
