import 'dart:async';

import 'package:crypto_tracker/models/api.dart';
import 'package:crypto_tracker/models/cryptocurrency.dart';
import 'package:crypto_tracker/models/local_storage.dart';
import 'package:flutter/material.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoCurrency> markets = [];

  MarketProvider() {
    fetchData();
  }

  CryptoCurrency fetchCryptoById(String id) {
    CryptoCurrency cryptoCurrency =
        markets.where((element) => element.id == id).toList().first;
    return cryptoCurrency;
  }

  void addFavourite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavourite = true;

    await LocalStorage.addFavourite(crypto.id!);
    notifyListeners();
  }

  void removeFavourite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavourite = false;

    await LocalStorage.removeFavourite(crypto.id!);
    notifyListeners();
  }

  Future<void> fetchData() async {
    var _markets = await API.getMarkets();
    List<String> favourites = await LocalStorage.fetchFavourites();

    List<CryptoCurrency> temp = [];
    for (var market in _markets) {
      CryptoCurrency newCrypto = CryptoCurrency.fromJSON(market);
      if (favourites.contains(newCrypto.id)) {
        newCrypto.isFavourite = true;
      }
      temp.add(newCrypto);
    }
    isLoading = false;
    markets = temp;
    notifyListeners();
    // Timer(const Duration(seconds: 3), () {
    //   fetchData();
    //   log("Data Updated");
    // });
  }
}
