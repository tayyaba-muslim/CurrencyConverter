import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/saved_conversions_model.dart';

class ConversionHistoryScreen extends StatelessWidget {
  static const String routeName = '/conversion-history';

  const ConversionHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if the user is logged in
    final user = FirebaseAuth.instance.currentUser;

    // If no user is logged in, show a message
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('User not logged in')),
      );
    }

    // Once user is logged in, proceed with fetching conversion history
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversion History', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 4, 0, 8),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 22, 10, 34),
      body: _buildExchangeTable(user.uid),
    );
  }

  // Method to fetch exchange table
  Widget _buildExchangeTable(String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('saved_conversions')
          .where('userId', isEqualTo: userId)
          //.orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        }

        // Error state
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading history.', style: TextStyle(color: Colors.white)));
        }

        // No data found
        final conversions = snapshot.data?.docs
                .map((doc) => SavedConversion.fromMap(doc.data() as Map<String, dynamic>))
                .toList() ?? [];

        if (conversions.isEmpty) {
          return const Center(child: Text('No conversions found.', style: TextStyle(color: Colors.white70)));
        }

        // Display conversions in ListView
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: conversions.length,
          itemBuilder: (context, index) {
            final conversion = conversions[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 35, 21, 45),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                title: Text(
                  '${conversion.convertedAmount.toStringAsFixed(2)} ${conversion.convertedCurrency}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  'From ${conversion.defaultCurrency}',
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: Text(
                  conversion.createdAt?.toDate().toString().substring(0, 16) ?? '',
                  style: const TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
