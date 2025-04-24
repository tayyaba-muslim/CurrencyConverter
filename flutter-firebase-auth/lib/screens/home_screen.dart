import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_demo/screens/login_screen.dart';
import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';
import 'package:firebase_auth_demo/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/saved_conversions_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _sendController = TextEditingController();
  double _convertedAmount = 0.0;
  double _exchangeRate = 0.0036;
  String _defaultCurrency = 'PKR';
  String _selectedCurrency = 'USD';
  String? _userId; // Changed from late initialization to nullable

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print('>>>><<<< UID: ${user.uid}, Email: ${user.email}');
      _userId = user.uid;
      _loadUserSettings();
    } else {
      print('>>>><<<< User is null!');
      // You might want to redirect to login or show an error
    }
  }

  void _loadUserSettings() async {
    if (_userId != null) {
      final doc = await FirebaseFirestore.instance
          .collection('app_settings')
          .doc(_userId)
          .get();
      if (doc.exists) {
        setState(() {
          _defaultCurrency = doc['defaultCurrency'] ?? 'PKR';
          _selectedCurrency = _defaultCurrency;
          _exchangeRate = _getExchangeRate(_defaultCurrency, _selectedCurrency);
        });
      }
    }
  }

  double _getExchangeRate(String from, String to) {
    const rates = {
      'PKR->USD': 0.0036,
      'PKR->EUR': 0.0033,
      'USD->PKR': 277.0,
      'EUR->PKR': 303.0,
      'USD->EUR': 0.92,
      'EUR->USD': 1.09,
    };
    return rates['$from->$to'] ?? 1.0;
  }

  void _convertCurrency() {
    double sendAmount = double.tryParse(_sendController.text) ?? 0.0;
    double rate = _getExchangeRate(_defaultCurrency, _selectedCurrency);
    setState(() {
      _exchangeRate = rate;
      _convertedAmount = sendAmount * rate;
    });
  }

  void _resetConversion() {
    setState(() {
      _sendController.clear();
      _convertedAmount = 0.0;
      _selectedCurrency = _defaultCurrency;
    });
  }

  void _saveConversion() async {
    if (_userId == null) return; // Ensure _userId is not null

    final double sendAmount = double.tryParse(_sendController.text) ?? 0.0;
    if (sendAmount == 0.0) {
      // Show a popup (SnackBar in this case) to notify the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter an amount greater than 0.')),
      );
      return; // Exit the function if the amount is zero
    }
    final double receiveAmount = sendAmount * _exchangeRate;

    final savedConversion = SavedConversion(
      id: DateTime.now().toIso8601String(),
      userId: _userId!,
      defaultCurrency: _defaultCurrency,
      convertedCurrency: _selectedCurrency,
      convertedAmount: receiveAmount,
    );

    await FirebaseFirestore.instance.collection('saved_conversions').add({
      ...savedConversion.toMap(),
      'createdAt': Timestamp.now(),
    });
  }

  void _showProfileDialog(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Profile Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!user.isAnonymous && user.phoneNumber == null)
                  Text('Email: ${user.email!}'),
                if (!user.isAnonymous && user.phoneNumber == null)
                  Text('Provider: ${user.providerData[0].providerId}'),
                if (user.phoneNumber != null)
                  Text('Phone: ${user.phoneNumber!}'),
                Text('UID: ${user.uid}'),
                const SizedBox(height: 16),
                if (!user.emailVerified && !user.isAnonymous)
                  CustomButton(
                    onTap: () {
                      context
                          .read<FirebaseAuthMethods>()
                          .sendEmailVerification(context);
                    },
                    text: 'Verify Email',
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null || _userId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Currency App', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 4, 0, 8),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () => _showProfileDialog(context, user),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) async {
              // Marked as async to use await inside it
              switch (value) {
                case 'signout':
                  // Call the signOut method from FirebaseAuthMethods
                  await context.read<FirebaseAuthMethods>().signOut(context);

                  // After sign out, navigate to the login screen and remove all previous screens from the stack
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginScreen()), // Replace with your login screen widget
                    (route) =>
                        false, // This ensures that all routes are removed from the stack
                  );
                  break;
                case 'delete':
                  await context
                      .read<FirebaseAuthMethods>()
                      .deleteAccount(context);
                  break;
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'signout', child: Text('Sign Out')),
              PopupMenuItem(value: 'delete', child: Text('Delete Account')),
            ],
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildConversionBox(),
            const SizedBox(height: 24),
            _buildExchangeTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildConversionBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 22, 10, 34),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Currency Exchange',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          const SizedBox(height: 12),
          const Text('Amount',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 4),
          TextFormField(
            controller: _sendController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Amount',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButton<String>(
            dropdownColor: const Color.fromARGB(255, 35, 21, 45),
            value: _selectedCurrency,
            onChanged: (value) {
              setState(() {
                _selectedCurrency = value!;
                _exchangeRate =
                    _getExchangeRate(_defaultCurrency, _selectedCurrency);
              });
            },
            items: [
              'USD',
              'PKR',
              'EUR',
              'GBP',
              'INR',
              'CAD',
              'AUD',
              'CNY',
              'JPY'
            ].map((currency) {
              return DropdownMenuItem(
                value: currency,
                child: Text(
                  currency,
                  style: TextStyle(
                    color: currency == _defaultCurrency
                        ? Colors.white
                        : Colors.grey[300],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 44, 21, 68),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Converted:',
                    style: TextStyle(color: Colors.white70, fontSize: 16)),
                Text(
                  '${_convertedAmount.toStringAsFixed(2)} $_selectedCurrency',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _convertCurrency,
                  child: const Text('Convert'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: _resetConversion,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text('Reset'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: _saveConversion,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// copy
  Widget _buildExchangeTable() {
    if (_userId == null)
      return const Center(child: Text('User not authenticated'));

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('saved_conversions')
          .where('userId', isEqualTo: _userId)
          // .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error loading data.'));
        }

        final conversions = snapshot.data?.docs
                .map((doc) =>
                    SavedConversion.fromMap(doc.data() as Map<String, dynamic>))
                .toList() ??
            [];

        return ListView.builder(
          shrinkWrap: true,
          itemCount: conversions.length,
          itemBuilder: (context, index) {
            final conversion = conversions[index];
            return ListTile(
              title: Text(
                  '${conversion.convertedAmount} ${conversion.convertedCurrency}'),
              subtitle: Text('From ${conversion.defaultCurrency}'),
              trailing: Text(conversion.createdAt!.toDate().toString()),
            );
          },
        );
      },
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(child: Text('Menu')),
          ListTile(
            title: const Text('Home'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('About'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
