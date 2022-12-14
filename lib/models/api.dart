import 'dart:convert';
import 'dart:developer';

import 'package:crypto_tracker/constants/api_key.dart';
import 'package:http/http.dart' as http;

class API {
  static Future<List<dynamic>> getMarkets() async {
    try {
      Uri requestPath = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=20&page=1&sparkline=false");
      var response = await http.get(requestPath);
      var decodedResponse = jsonDecode(response.body);

      List<dynamic> markets = decodedResponse as List<dynamic>;

      return markets;
    } catch (e) {
      return [];
    }
  }

  static Future<List<dynamic>> getNews() async {
    try {
      Uri requestPath = Uri.parse(
          "https://newsdata.io/api/1/news?apikey=$apiKey&q=cryptocurrency&country=ca,cn,in,gb,us&language=en");

      var response = await http.get(requestPath);
      var result = jsonDecode(response.body);
      List<dynamic> news = result['results'] as List<dynamic>;
      log(news.toString());
      return news;
    } catch (e) {
      return [];
    }
  }

  static Future<List<dynamic>> getPrices(String id) async {
    Uri requestPath = Uri.parse(
        "https://api.coingecko.com/api/v3/coins/$id/market_chart?vs_currency=inr&days=7");
    var response = await http.get(requestPath);

    var decodedResponse = jsonDecode(response.body);
    List<dynamic> result = decodedResponse["prices"];
    return result;
  }
}
