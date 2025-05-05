import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/saved_conversions_model.dart';

class ConversionHistoryScreen extends StatelessWidget {
  static const String routeName = '/conversion-history';

  const ConversionHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            'User not logged in',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 26, 5, 19),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversion History', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 8, 0, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 26, 5, 19),
      body: _buildExchangeTable(user.uid),
    );
  }

  Widget _buildExchangeTable(String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('saved_conversions')
          .where('userId', isEqualTo: userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text(
              'Error loading history.',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        final conversions = snapshot.data?.docs
                .map((doc) => SavedConversion.fromMap(doc.data() as Map<String, dynamic>))
                .toList() ??
            [];

        if (conversions.isEmpty) {
          return const Center(
            child: Text(
              'No conversions found.',
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: conversions.length,
          itemBuilder: (context, index) {
            final conversion = conversions[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 35, 21, 45),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.25), // White shadow
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                title: Text(
                  '${conversion.convertedAmount.toStringAsFixed(2)} ${conversion.convertedCurrency}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
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
