import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_setting_model.dart'; // Import your AppSettings model

class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  AppSettings _settings = AppSettings(userId: '', defaultCurrency: 'USD'); // Default settings

  AppSettings get settings => _settings; // Getter for settings

  UserProvider() {
    _loadUserSettings(); // Load settings when the provider is created
  }

  // Load user settings from Firestore
  Future<void> _loadUserSettings() async {
    final user = _auth.currentUser; // Get current user
    if (user != null) {
      // If user is logged in, load their settings
      final doc = await _db.collection('app_settings').doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        _settings = AppSettings.fromMap(data); // Convert Firestore data to AppSettings
      } else {
        // If no settings exist, create a default entry
        _settings = AppSettings(userId: user.uid, defaultCurrency: 'USD');
        await _db.collection('app_settings').doc(user.uid).set(_settings.toMap()); // Save default settings
      }
      notifyListeners(); // Notify listeners to update UI
    }
  }

  // Method to set the default currency
   Future<void> setDefaultCurrency(String currency) async {
    final user = _auth.currentUser; // Get current user
    if (user != null) {
      // Check if the new currency is different
      if (_settings.defaultCurrency != currency) {
        // If it's different, update the settings locally and in Firestore
        _settings = AppSettings(userId: user.uid, defaultCurrency: currency); // Update settings object locally
        await _db.collection('app_settings').doc(user.uid).update({
          'defaultCurrency': currency, // Update Firestore document with new currency
        });
        notifyListeners(); // Notify listeners to update UI
      } else {
        // If currency is the same, show an error message
        print('Currency is already set to $currency. No update needed.');
      }
    }
  }
}
