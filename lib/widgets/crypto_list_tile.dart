import 'package:crypto_tracker/models/cryptocurrency.dart';
import 'package:crypto_tracker/providers/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/details.dart';

class CryptoTileList extends StatelessWidget {
  final CryptoCurrency currentCrypto;
  const CryptoTileList({Key? key, required this.currentCrypto})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider =
        Provider.of<MarketProvider>(context, listen: false);
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return DetailsPage(
              id: currentCrypto.id.toString(),
            );
          },
        ));
      },
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(
          currentCrypto.image!,
        ),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              "${currentCrypto.name!} #${currentCrypto.marketCapRank}",
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          (currentCrypto.isFavourite == false)
              ? GestureDetector(
                  onTap: () {
                    marketProvider.addFavourite(currentCrypto);
                  },
                  child: const Icon(
                    CupertinoIcons.heart,
                    size: 16,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    marketProvider.removeFavourite(currentCrypto);
                  },
                  child: const Icon(
                    CupertinoIcons.heart_fill,
                    size: 16,
                    color: Colors.red,
                  ),
                )
        ],
      ),
      subtitle: Text(currentCrypto.symbol.toString().toUpperCase()),
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
              double priceChange = currentCrypto.priceChange24!;
              double priceChangePercentage =
                  currentCrypto.priceChangePercentage24!;
              if (priceChange < 0) {
                return Text(
                  "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                  style: const TextStyle(color: Colors.red),
                );
              } else {
                return Text(
                  "+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                  style: const TextStyle(color: Colors.green),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
