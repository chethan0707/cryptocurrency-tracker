// import 'package:crypto_tracker/models/chart_model.dart';
// import 'package:flutter/foundation.dart';

// import '../models/api.dart';

// class PriceProvider with ChangeNotifier {
//   List<Prices> prices = [];
//   PriceProvider.m() {}

//   PriceProvider(String id) {
//     fetchPrices(id);
//   }

//   Future<List<Prices>> getTimeAndPrices(String id) async {
//     List<dynamic> temp = await API.getPrices(id);
//     List<Prices> chartsData = [];
//     for (var item in temp) {
//       Prices chart = Prices.fromJSON(item);
//       chartsData.add(chart);
//     }
//     return chartsData;
//   }

//   getData(String id) async{
//     return await  getTimeAndPrices(id);
//   }

//   Future<void> fetchPrices(String id) async {
//     prices = await getTimeAndPrices(id);
//     // log("called from provider");
//     // log(prices.length.toString());
//     notifyListeners();
//   }
// }
