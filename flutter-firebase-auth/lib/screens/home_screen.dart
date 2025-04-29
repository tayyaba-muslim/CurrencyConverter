import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_demo/screens/login_screen.dart';
import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';
import 'package:firebase_auth_demo/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart'; 
import '../models/saved_conversions_model.dart';
import 'package:firebase_auth_demo/screens/conversion_history_screen.dart';
import 'package:firebase_auth_demo/screens/default_currency_screen.dart';
import 'package:firebase_auth_demo/screens/rate_alerts_screen.dart';
import 'package:firebase_auth_demo/screens/currency_news_screen.dart';
import 'package:firebase_auth_demo/screens/help_center_screen.dart';

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
  _userId = FirebaseAuth.instance.currentUser?.uid;
  _loadUserSettings();
  _listenToCurrencyChanges();
}

void _listenToCurrencyChanges() {
  if (_userId != null) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(_userId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        final settings = snapshot.data()?['settings'] ?? {};
        setState(() {
          // Ensure the selected currency is updated from the settings.
          _defaultCurrency = settings['defaultCurrency'] ?? 'USD';
          _selectedCurrency = _defaultCurrency;  // Keep the selected currency updated
          _exchangeRate = _getExchangeRate(_defaultCurrency, _selectedCurrency);
          print('Currency updated via listener: $_defaultCurrency');
        });
      }
    });
  }
}

void _updateCurrencyInFirestore(String newCurrency) async {
  if (_userId != null) {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userId) 
          .update({
        'settings.defaultCurrency': newCurrency,
      });

      // Once Firestore is updated, call setState to update UI
      setState(() {
        _defaultCurrency = newCurrency;
        _selectedCurrency = newCurrency;  // Ensure the selected currency is updated
        _exchangeRate = _getExchangeRate(_defaultCurrency, _selectedCurrency);
      });
      print('Currency updated successfully in Firestore');
    } catch (e) {
      print('Error updating currency: $e');
    }
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
        _selectedCurrency = _defaultCurrency;  // Make sure selected currency is updated here as well
        _exchangeRate = _getExchangeRate(_defaultCurrency, _selectedCurrency);
        print('Default Currency: $_defaultCurrency');
        print('Selected Currency: $_selectedCurrency');
      });
    } else {
      print('No data found for this user in Firestore');
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

  // Debugging: Log to confirm correct values
  print('Current Currency: $_selectedCurrency');
  print('Exchange Rate: $rate');
  
  setState(() {
    _exchangeRate = rate;  // Update the exchange rate
    _convertedAmount = sendAmount * rate;  // Perform conversion with updated rate
  });
  print('Converted Amount: $_convertedAmount');
}




  void _resetConversion() {
    setState(() {
      _sendController.clear();
      _convertedAmount = 0.0;
      _selectedCurrency = _defaultCurrency;
    });
  }

void _saveConversion() async {
  if (_userId == null) return;

  final double sendAmount = double.tryParse(_sendController.text) ?? 0.0;
  if (sendAmount == 0.0) {
    _showErrorAlert('Please enter an amount greater than 0.');
    return;
  }

  final double receiveAmount = sendAmount * _exchangeRate;

  // Check if this conversion already exists
  final existingConversion = await FirebaseFirestore.instance
      .collection('saved_conversions')
      .where('userId', isEqualTo: _userId)
      .where('defaultCurrency', isEqualTo: _defaultCurrency)
      .where('convertedCurrency', isEqualTo: _selectedCurrency)
      .where('convertedAmount', isEqualTo: receiveAmount)
      .get();

  if (existingConversion.docs.isNotEmpty) {
    _showErrorAlert('This conversion has already been saved!');
    return; 
  }

  final savedConversion = SavedConversion(
    id: DateTime.now().toIso8601String(),
    userId: _userId!,
    defaultCurrency: _defaultCurrency,
    convertedCurrency: _selectedCurrency,
    convertedAmount: receiveAmount,
    originalAmount: sendAmount,  // Store the original amount
  );

  await FirebaseFirestore.instance.collection('saved_conversions').add({
    ...savedConversion.toMap(),
    'createdAt': Timestamp.now(),
    'userId': _userId,
  });

  _showSuccessAlert('Conversion saved successfully!');
}


void _showErrorAlert(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), backgroundColor: Colors.red),
  );
}

void _showSuccessAlert(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), backgroundColor: Colors.green),
  );
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
    print('Build Method: Selected Currency is $_selectedCurrency');
    final user = FirebaseAuth.instance.currentUser;

    if (user == null || _userId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
       appBar: AppBar(
         title: Text(
        'Currency App ($_selectedCurrency)', // Show selected currency in the app bar for debugging
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
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
    String defaulCurrency=_defaultCurrency;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 22, 10, 34),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(
          'Currency Exchange, $_defaultCurrency',
           style: const TextStyle(fontSize: 20, color: Colors.white),
             ),

          const SizedBox(height: 12),
          const Text('Amount',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 4),
         TextFormField(
        controller: _sendController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
         hintText: 'Amount',  // Use the dynamic variable here
        border: const OutlineInputBorder(),
    ),
   ),

          const SizedBox(height: 12),
DropdownButton<String>(
  dropdownColor: const Color.fromARGB(255, 35, 21, 45),
  value: _selectedCurrency,
  onChanged: (value) {
    if (value != _selectedCurrency) {
   setState(() {
        _selectedCurrency = value!;
        _exchangeRate = _getExchangeRate(_defaultCurrency, _selectedCurrency);
        print('Selected Currency Changed: $_selectedCurrency');
        print('Updated Exchange Rate: $_exchangeRate');
      });
    } else {
      print("The selected currency is the same as the current one.");
    }
    print('Selected Currency Changed: $_selectedCurrency');
      print('Updated Exchange Rate: $_exchangeRate');
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
              subtitle: Text('From ${conversion.defaultCurrency} ${conversion.originalAmount}' ),
              trailing: Text(conversion.createdAt!.toDate().toString()),
            );
          },
        );
      },
    );
  }

  Widget _buildDrawer() {
     return Drawer(
    backgroundColor: const Color.fromARGB(255, 35, 21, 45),
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(168, 33, 0, 49), Color(0xFF4B0082)],
            ),
          ),
          child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
        ),
        ListTile(
          leading: const Icon(Icons.home, color: Colors.white),
          title: const Text('Home', style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          },
        ),
        ExpansionTile(
          leading: const Icon(Icons.settings, color: Colors.white),
          title: const Text('Settings', style: TextStyle(color: Colors.white)),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          children: [
            ListTile(
              leading: const Icon(Icons.history, color: Colors.white70),
              title: const Text('Conversion History', style: TextStyle(color: Colors.white70)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ConversionHistoryScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.currency_exchange, color: Colors.white70),
              title: const Text('Default Currency', style: TextStyle(color: Colors.white70)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DefaultCurrencyScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_active, color: Colors.white70),
              title: const Text('Rate Alerts', style: TextStyle(color: Colors.white70)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RateAlertsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.trending_up, color: Colors.white70),
              title: const Text('Currency News', style: TextStyle(color: Colors.white70)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CurrencyNewsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.support_agent, color: Colors.white70),
              title: const Text('Help Center', style: TextStyle(color: Colors.white70)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HelpCenterScreen()),
                );
              },
            ),
          ],
        ),
        ListTile(
          leading: const Icon(Icons.info, color: Colors.white),
          title: const Text('About', style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.pop(context);
            // About page navigation
            showAboutDialog(
              context: context,
              applicationName: 'Currency App',
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2025 Your Company',
            );
          },
        ),
      ],
    ),
  );
  }
}
