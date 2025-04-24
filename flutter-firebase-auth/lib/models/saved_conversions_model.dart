import 'package:cloud_firestore/cloud_firestore.dart';

class SavedConversion {
  final String id;
  final String userId;
  final String defaultCurrency;
  final String convertedCurrency;
  final double convertedAmount;
  final Timestamp? createdAt;

  SavedConversion({
    required this.id,
    required this.userId,
    required this.defaultCurrency,
    required this.convertedCurrency,
    required this.convertedAmount,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'defaultCurrency': defaultCurrency,
      'convertedCurrency': convertedCurrency,
      'convertedAmount': convertedAmount,
      'createdAt': FieldValue.serverTimestamp(), // Firestore timestamp
    };
  }

  factory SavedConversion.fromMap(Map<String, dynamic> map) {
    print("🧪 Debug fromMap: $map"); // Optional: helpful for debugging bad docs

    return SavedConversion(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      defaultCurrency: map['defaultCurrency'] ?? '',
      convertedCurrency: map['convertedCurrency'] ?? '',
      convertedAmount: _toDouble(map['convertedAmount']),
      createdAt: map['createdAt'],
    );
  }

  static double _toDouble(dynamic value) {
    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}
