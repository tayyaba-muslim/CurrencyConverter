class ConversionHistory {
  final String id;
  final String fromCurrency;
  final String toCurrency;
  final double amount;
  final double result;
  final DateTime date;

  ConversionHistory({
    required this.id,
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
    required this.result,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fromCurrency': fromCurrency,
      'toCurrency': toCurrency,
      'amount': amount,
      'result': result,
      'date': date.toIso8601String(),
    };
  }

  factory ConversionHistory.fromMap(Map<String, dynamic> map) {
    return ConversionHistory(
      id: map['id'],
      fromCurrency: map['fromCurrency'],
      toCurrency: map['toCurrency'],
      amount: map['amount'],
      result: map['result'],
      date: DateTime.parse(map['date']),
    );
  }
}
