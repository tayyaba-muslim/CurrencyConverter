import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/saved_conversions_model.dart';
import '../services/firebase_auth_methods.dart';
import '../widgets/custom_button.dart';

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

  @override
  void initState() {
    super.initState();
    _loadUserSettings();
  }

  void _loadUserSettings() async {
    final user = context.read<FirebaseAuthMethods>().user;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('app_settings')
          .doc(user.uid)
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

  void _saveConversion(String userId) async {
    final double sendAmount = double.tryParse(_sendController.text) ?? 0.0;
    final double receiveAmount = sendAmount * _exchangeRate;

    final savedConversion = SavedConversion(
      id: DateTime.now().toIso8601String(),
      userId: userId,
      defaultCurrency: _defaultCurrency,
      convertedCurrency: _selectedCurrency,
      convertedAmount: receiveAmount,
    );

    await FirebaseFirestore.instance.collection('saved_conversions').add({
      ...savedConversion.toMap(),
      'createdAt': Timestamp.now(),
    });

    setState(() {
      _convertedAmount = receiveAmount;
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
                      context.read<FirebaseAuthMethods>().sendEmailVerification(context);
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
    final user = context.read<FirebaseAuthMethods>().user;

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency App', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 4, 0, 8),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () => _showProfileDialog(context, user),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              switch (value) {
                case 'signout':
                  context.read<FirebaseAuthMethods>().signOut(context);
                  break;
                case 'delete':
                  context.read<FirebaseAuthMethods>().deleteAccount(context);
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
            _buildConversionBox(user.uid),
            const SizedBox(height: 24),
            _buildExchangeTable(user.uid),
          ],
        ),
      ),
    );
  }

  Widget _buildConversionBox(String userId) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 22, 10, 34),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Currency Exchange', style: TextStyle(fontSize: 20, color: Colors.white)),
          const SizedBox(height: 12),
          const Text('Amount', style: TextStyle(color: Colors.white, fontSize: 16)),
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
                _exchangeRate = _getExchangeRate(_defaultCurrency, _selectedCurrency);
              });
            },
            items: [
              'USD', 'PKR', 'EUR', 'GBP', 'INR', 'CAD', 'AUD', 'CNY', 'JPY'
            ].map((currency) {
              return DropdownMenuItem(
                value: currency,
                child: Text(
                  currency,
                  style: TextStyle(
                    color: currency == _defaultCurrency ? Colors.white : Colors.grey[300],
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
                const Text('Converted:', style: TextStyle(color: Colors.white70, fontSize: 16)),
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
                  onPressed: () => _saveConversion(userId),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExchangeTable(String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('saved_conversions')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No saved conversions yet.', style: TextStyle(color: Colors.white));
        }

        final rows = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return DataRow(cells: [
            DataCell(Text(data['convertedCurrency'], style: const TextStyle(color: Colors.white))),
            DataCell(Text((data['convertedAmount'] as num).toStringAsFixed(4), style: const TextStyle(color: Colors.white))),
          ]);
        }).toList();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(const Color.fromARGB(255, 4, 0, 8)),
            dataRowColor: MaterialStateProperty.all(const Color.fromARGB(255, 22, 10, 34)),
            columns: const [
              DataColumn(label: Text('Converted Currency', style: TextStyle(color: Colors.white))),
              DataColumn(label: Text('Amount', style: TextStyle(color: Colors.white))),
            ],
            rows: rows,
          ),
        );
      },
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 35, 21, 45),
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color.fromARGB(168, 33, 0, 49), Color(0xFF4B0082)]),
            ),
            child: Text('Navigation', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.white),
            title: Text('Home', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.info, color: Colors.white),
            title: Text('About', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
