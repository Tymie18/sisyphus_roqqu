class Symbols {
  Symbols({
    this.symbol = '',
    this.price = '',
  });

  factory Symbols.fromJson(Map<String, dynamic> json) {
    return Symbols(
      symbol: json['symbol'],
      price: json['price'],
    );
  }

  String? symbol;
  String? price;
}
