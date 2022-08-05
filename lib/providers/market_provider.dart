import 'dart:async';
import 'dart:developer';

import 'package:crypto_tracker/models/api.dart';
import 'package:crypto_tracker/models/cryptocurrency.dart';
import 'package:flutter/material.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoCurrency> markets = [];

  MarketProvider() {
    fetchData();
  }

  void fetchData() async {
    var _markets = await API.getMarkets();
    List<CryptoCurrency> temp = [];
    for (var market in _markets) {
      CryptoCurrency newCrypto = CryptoCurrency.fromJSON(market);
      temp.add(newCrypto);
    }

    isLoading = false;
    markets = temp;
    notifyListeners();

    Timer(const Duration(seconds: 3), () {
      fetchData();
      log("Data Updated");
    });
  }
}
