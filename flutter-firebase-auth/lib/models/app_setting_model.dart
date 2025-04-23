class AppSettings {
  final String userId;
  final String defaultCurrency;

  AppSettings({required this.userId, required this.defaultCurrency});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'defaultCurrency': defaultCurrency,
    };
  }

  factory AppSettings.fromMap(Map<String, dynamic> map) {
    return AppSettings(
      userId: map['userId'],
      defaultCurrency: map['defaultCurrency'],
    );
  }
}
