import 'package:crypto_tracker/models/cryptocurrency.dart';
import 'package:crypto_tracker/providers/market_provider.dart';
import 'package:crypto_tracker/widgets/crypto_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        List<CryptoCurrency> favourites = marketProvider.markets
            .where((element) => element.isFavourite == true)
            .toList();
        if (favourites.isNotEmpty) {
          return ListView.builder(
            itemBuilder: (context, index) {
              CryptoCurrency currentCrypto = favourites[index];
              return CryptoTileList(currentCrypto: currentCrypto);
            },
            itemCount: favourites.length,
          );
        } else {
          return const Center(
            child: Text(
              "No favourites added",
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
          );
        }
      },
    );
  }
}
