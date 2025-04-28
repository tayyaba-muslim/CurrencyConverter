class AppSettings {
  final String userId;
  final String defaultCurrency;

  AppSettings({required this.userId, required this.defaultCurrency});

  // Convert a map to AppSettings (for Firestore document data)
  factory AppSettings.fromMap(Map<String, dynamic> map) {
    return AppSettings(
      userId: map['userId'] as String,
      defaultCurrency: map['defaultCurrency'] as String,
    );
  }

  // Convert AppSettings to a map (for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'defaultCurrency': defaultCurrency,
    };
  }
}
