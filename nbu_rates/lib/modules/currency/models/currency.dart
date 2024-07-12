
class Currency {
  final String cc;
  final String enname;
  final double rate;

  Currency({required this.cc, required this.enname, required this.rate});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      cc: json['cc'],
      enname: json['enname'],
      rate: json['rate'],
    );
  }
}