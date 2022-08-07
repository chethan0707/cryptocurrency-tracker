import 'package:crypto_tracker/widgets/crypto_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cryptocurrency.dart';
import '../providers/market_provider.dart';

class Markets extends StatelessWidget {
  const Markets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketprovider, child) {
        if (marketprovider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (marketprovider.markets.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await marketprovider.fetchData();
              },
              child: ListView.builder(
                itemCount: marketprovider.markets.length,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  CryptoCurrency currentCrypto = marketprovider.markets[index];
                  return CryptoTileList(currentCrypto: currentCrypto);
                },
              ),
            );
          } else {
            return const Text("data not found");
          }
        }
      },
    );
  }
}
