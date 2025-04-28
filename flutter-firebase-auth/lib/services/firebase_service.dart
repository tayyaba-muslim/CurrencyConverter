import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_demo/models/conversion_history_model.dart';
import 'package:firebase_auth_demo/models/rate_alert_model.dart';
import 'package:firebase_auth_demo/models/user_settings_model.dart';
import '../models/conversion_history_model.dart';
import '../models/rate_alert_model.dart';
import '../models/user_settings_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save Conversion History
  Future<void> saveConversion(ConversionHistory history, String uid) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('conversions')
        .doc(history.id)
        .set(history.toMap());
  }

  // Save Rate Alert
  Future<void> saveRateAlert(RateAlert alert, String uid) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('rate_alerts')
        .doc(alert.id)
        .set(alert.toMap());
  }

  // Set User Settings
  Future<void> setUserSettings(UserSettings settings) async {
    await _firestore
        .collection('users')
        .doc(settings.uid)
        .collection('settings')
        .doc('preferences')
        .set(settings.toMap());
  }

  // Get User Settings
  Future<UserSettings?> getUserSettings(String uid) async {
    var doc = await _firestore
        .collection('users')
        .doc(uid)
        .collection('settings')
        .doc('preferences')
        .get();

    if (doc.exists) {
      return UserSettings.fromMap(doc.data()!);
    } else {
      return null;
    }
  }
}
