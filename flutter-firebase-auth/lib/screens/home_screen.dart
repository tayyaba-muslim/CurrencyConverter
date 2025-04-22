import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';
import 'package:firebase_auth_demo/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _sendController = TextEditingController();
  double _convertedAmount = 0.0;
  final double exchangeRate = 26.0; // BTC to ETH

  void _convertCurrency() {
    final double sendAmount = double.tryParse(_sendController.text) ?? 0.0;
    setState(() {
      _convertedAmount = sendAmount * exchangeRate;
    });
  }

  void _saveExchange(String userId) async {
    final double sendAmount = double.tryParse(_sendController.text) ?? 0.0;
    final double receiveAmount = sendAmount * exchangeRate;

    await FirebaseFirestore.instance.collection('exchanges').add({
      'userId': userId,
      'sendCurrency': 'BTC',
      'receiveCurrency': 'ETH',
      'sendAmount': sendAmount,
      'receiveAmount': receiveAmount,
      'rate': exchangeRate,
      'createdAt': FieldValue.serverTimestamp(),
    });

    setState(() {
      _convertedAmount = receiveAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency App', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 4, 0, 8),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.account_circle),
            onSelected: (value) {
              switch (value) {
                case 'profile':
                  _showProfileDialog(context, user);
                  break;
                case 'signout':
                  context.read<FirebaseAuthMethods>().signOut(context);
                  break;
                case 'delete':
                  context.read<FirebaseAuthMethods>().deleteAccount(context);
                  break;
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'profile', child: Text('My Profile')),
              PopupMenuItem(value: 'signout', child: Text('Sign Out')),
              PopupMenuItem(value: 'delete', child: Text('Delete Account')),
            ],
          )
        ],
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildExchangeBox(user.uid),
            const SizedBox(height: 30),
            _buildExchangeTable(user.uid),
          ],
        ),
      ),
    );
  }

  Widget _buildExchangeBox(String userId) {
    return Center(
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 22, 10, 34),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Currency Exchange', style: TextStyle(fontSize: 24, color: Colors.white)),
            const SizedBox(height: 20),
            const Text('You send (BTC)', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            TextField(
              controller: _sendController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: 'Enter amount',
              ),
            ),
            const SizedBox(height: 20),
            const Text('You receive (ETH)', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(_convertedAmount.toStringAsFixed(4)),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 143, 0, 255),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: _convertCurrency,
                    child: const Text('Exchange Now', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  onPressed: () => _saveExchange(userId),
                  child: const Text('Save', style: TextStyle(color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildExchangeTable(String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('exchanges')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No saved exchanges yet.', style: TextStyle(color: Colors.white));
        }

        final rows = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return DataRow(
            cells: [
              DataCell(Text(data['sendAmount'].toString(), style: const TextStyle(color: Colors.white))),
              DataCell(Text((data['receiveAmount'] as num).toStringAsFixed(4), style: const TextStyle(color: Colors.white))),
              DataCell(Text(data['rate'].toString(), style: const TextStyle(color: Colors.white))),
            ],
          );
        }).toList();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(const Color.fromARGB(255, 4, 0, 8)),
            dataRowColor: MaterialStateProperty.all(const Color.fromARGB(255, 22, 10, 34)),
            columns: const [
              DataColumn(label: Text('Send (BTC)', style: TextStyle(color: Colors.white))),
              DataColumn(label: Text('Receive (ETH)', style: TextStyle(color: Colors.white))),
              DataColumn(label: Text('Rate', style: TextStyle(color: Colors.white))),
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
              gradient: LinearGradient(
                colors: [Color.fromARGB(168, 33, 0, 49), Color(0xFF4B0082)],
              ),
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
          ListTile(
            leading: Icon(Icons.contact_mail, color: Colors.white),
            title: Text('Contact', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showProfileDialog(BuildContext context, user) {
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
}
