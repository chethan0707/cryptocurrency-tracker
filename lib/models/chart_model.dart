class Prices {
  final DateTime? date;
  final double? price;

  Prices({required this.date, required this.price});

  factory Prices.fromJSON(List<dynamic> map) {
    return Prices(
        date: DateTime.fromMillisecondsSinceEpoch(map[0]),
        // price: double.tryParse(map[1].toString())!.round(),
        price: map[1]);
  }
}
