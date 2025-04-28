// models/user_settings.dart

class UserSettings {
  final String uid;
  final String defaultCurrency;

  // Corrected constructor
  UserSettings({
    required this.uid,
    required this.defaultCurrency,
  });

  // Firebase se data lene ke liye
  factory UserSettings.fromMap(Map<String, dynamic> map) {
    return UserSettings(
      uid: map['uid'] ?? '',
      defaultCurrency: map['defaultCurrency'] ?? 'USD',
    );
  }

  // Firebase mein data save karne ke liye
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'defaultCurrency': defaultCurrency,
    };
  }
}
