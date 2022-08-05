import 'package:crypto_tracker/models/cryptocurrency.dart';
import 'package:crypto_tracker/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Welcome back", style: TextStyle(fontSize: 20)),
              const Text(
                "Crypto today",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              Expanded(child: Consumer<MarketProvider>(
                builder: (context, marketprovider, child) {
                  if (marketprovider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (marketprovider.markets.isNotEmpty) {
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemBuilder: (context, index) {
                            CryptoCurrency currentCrypto =
                                marketprovider.markets[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                  currentCrypto.image!,
                                ),
                              ),
                              title: Text(
                                  "${currentCrypto.name!} #${currentCrypto.marketCapRank}"),
                              subtitle: Text(currentCrypto.symbol
                                  .toString()
                                  .toUpperCase()),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "₹ ${currentCrypto.currentPrice!.toStringAsFixed(4)}",
                                    style: const TextStyle(
                                        color: Color(0xff0395eb),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      double priceChange =
                                          currentCrypto.priceChange24!;
                                      double priceChangePercentage =
                                          currentCrypto
                                              .priceChangePercentage24!;
                                      if (priceChange < 0) {
                                        return Text(
                                          "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                                          style: const TextStyle(
                                              color: Colors.red),
                                        );
                                      } else {
                                        return Text(
                                          "+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                                          style: const TextStyle(
                                              color: Colors.green),
                                        );
                                      }
                                    },
                                  )
                                ],
                              ),
                            );
                          },
                          itemCount: marketprovider.markets.length);
                    } else {
                      return const Text("data not found");
                    }
                  }
                },
              ))
            ],
          ),
        ),
      )),
    );
  }
}
