class CryptoCurrency {
  final String? id;
  final String? symbol;
  final String? name;
  final String? image;
  final double? currentPrice;
  final double? marketCap;
  final int? marketCapRank;
  final double? high24;
  final double? low24;
  final double? priceChange24;
  final double? priceChangePercentage24;
  final double? circulatingSupply;
  final double? ath;
  final double? atl;
  bool isFavourite = false;

  CryptoCurrency({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.high24,
    required this.low24,
    required this.priceChange24,
    required this.priceChangePercentage24,
    required this.circulatingSupply,
    required this.ath,
    required this.atl,
    required this.isFavourite,
  });

  factory CryptoCurrency.fromJSON(Map<String, dynamic> map) {
    return CryptoCurrency(
        id: map['id'],
        symbol: map['symbol'],
        name: map['name'],
        image: map['image'],
        currentPrice: double.parse(map['current_price'].toString()),
        marketCap: double.parse(map['market_cap'].toString()),
        marketCapRank: map['market_cap_rank'],
        high24: double.parse(map['high_24h'].toString()),
        low24: double.parse(map['low_24h'].toString()),
        priceChange24: double.parse(map['price_change_24h'].toString()),
        priceChangePercentage24:
            double.parse(map['price_change_percentage_24h'].toString()),
        circulatingSupply: double.parse(map['circulating_supply'].toString()),
        ath: double.parse(map['ath'].toString()),
        atl: double.parse(map['atl'].toString()),
        isFavourite: false);
  }
}
