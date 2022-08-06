import 'package:crypto_tracker/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  const DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget titleAndDetails(
      String title, String detail, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Text(detail, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Consumer<MarketProvider>(
            builder: (context, marketProvider, child) {
              var currenCrypto = marketProvider.fetchCryptoById(widget.id);
              return RefreshIndicator(
                onRefresh: () async {
                  await marketProvider.fetchData();
                },
                child: ListView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(currenCrypto.image!),
                      ),
                      title: Text(
                        "${currenCrypto.name!} (${currenCrypto.symbol!.toUpperCase()})",
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                        "₹ ${currenCrypto.currentPrice!.toStringAsFixed(4)}",
                        style: const TextStyle(
                            color: Color(0xff0395eb),
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Price Change (24h)",
                          style: TextStyle(fontSize: 20),
                        ),
                        Builder(
                          builder: (context) {
                            double priceChange = currenCrypto.priceChange24!;
                            double priceChangePercentage =
                                currenCrypto.priceChangePercentage24!;
                            if (priceChange < 0) {
                              return Text(
                                "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 30),
                              );
                            } else {
                              return Text(
                                "+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                                style: const TextStyle(
                                    color: Colors.green, fontSize: 30),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetails(
                            "Market Cap",
                            "₹ ${currenCrypto.marketCap!.toStringAsFixed(4)}",
                            CrossAxisAlignment.start),
                        titleAndDetails(
                            "Market Cap Rank",
                            "#${currenCrypto.marketCapRank}",
                            CrossAxisAlignment.end)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetails(
                            "Low 24h",
                            "₹ ${currenCrypto.low24!.toStringAsFixed(4)}",
                            CrossAxisAlignment.start),
                        titleAndDetails("High 24h", "#${currenCrypto.high24!}",
                            CrossAxisAlignment.end)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        titleAndDetails(
                          "Circulating Supply",
                          currenCrypto.circulatingSupply!.toInt().toString(),
                          CrossAxisAlignment.start,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetails(
                          "All Time Low",
                          currenCrypto.atl!.toStringAsFixed(4),
                          CrossAxisAlignment.start,
                        ),
                        titleAndDetails(
                          "All Time High",
                          currenCrypto.ath!.toStringAsFixed(4),
                          CrossAxisAlignment.end,
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
        // child: Container(
      ),
    );
  }
}
