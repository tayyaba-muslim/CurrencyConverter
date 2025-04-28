class RateAlert {
  final String id;
  final String baseCurrency;
  final String targetCurrency;
  final double targetRate;

  RateAlert({
    required this.id,
    required this.baseCurrency,
    required this.targetCurrency,
    required this.targetRate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'baseCurrency': baseCurrency,
      'targetCurrency': targetCurrency,
      'targetRate': targetRate,
    };
  }

  factory RateAlert.fromMap(Map<String, dynamic> map) {
    return RateAlert(
      id: map['id'],
      baseCurrency: map['baseCurrency'],
      targetCurrency: map['targetCurrency'],
      targetRate: map['targetRate'],
    );
  }
}
