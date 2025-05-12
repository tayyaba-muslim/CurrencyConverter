import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_demo/screens/conversion_history_screen.dart';
import 'package:firebase_auth_demo/screens/currency_news_screen.dart';
import 'package:firebase_auth_demo/screens/customfooter.dart';
import 'package:firebase_auth_demo/screens/default_currency_screen.dart';
import 'package:firebase_auth_demo/screens/help_center_screen.dart';
import 'package:firebase_auth_demo/screens/home_screen.dart' as home;
import 'package:firebase_auth_demo/screens/login_email_password_screen.dart';
import 'package:firebase_auth_demo/screens/rate_alerts_screen.dart';
import 'package:firebase_auth_demo/screens/testimonial_page_screen.dart';
import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth_demo/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm(User user) async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('contacts').add({
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'email': user.email,
          'phone': _phoneController.text,
          'message': _messageController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });

        _firstNameController.clear();
        _lastNameController.clear();
        _phoneController.clear();
        _messageController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Message Sent!')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => home.HomeScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending message: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const EmailPasswordLogin()),
        );
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 45, 20, 55),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 6, 29),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Image.asset('assets/logo.png', height: 40),
            const SizedBox(width: 10),
            const Text('Currency App', style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () => _showProfileDialog(context, user),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) async {
              if (value == 'signout') {
                await context.read<FirebaseAuthMethods>().signOut(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const EmailPasswordLogin()),
                );
              } else if (value == 'delete') {
                await context.read<FirebaseAuthMethods>().deleteAccount(context);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'signout', child: Text('Sign Out')),
              PopupMenuItem(value: 'delete', child: Text('Delete Account')),
            ],
          ),
        ],
      ),
      drawer: _buildDrawer(user),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                width: 600,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 30, 15, 40),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Contact Us',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _firstNameController,
                              style: const TextStyle(color: Colors.white),
                              decoration: _inputDecoration('First Name'),
                              validator: (value) =>
                                  value == null || value.isEmpty ? 'Enter your first name' : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _lastNameController,
                              style: const TextStyle(color: Colors.white),
                              decoration: _inputDecoration('Last Name'),
                              validator: (value) =>
                                  value == null || value.isEmpty ? 'Enter your last name' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        initialValue: user.email,
                        readOnly: true,
                        style: const TextStyle(color: Colors.grey),
                        decoration: _inputDecoration('Email'),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration('Phone Number'),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Enter your phone number' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _messageController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Message"),
                        maxLines: 5,
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Enter your message' : null,
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: CustomButton(
                          label: 'Submit',
                          onPressed: () => _submitForm(user),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Divider(thickness: 1, color: Color.fromARGB(57, 250, 246, 246)),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: '  $label',
      labelStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: const Color.fromARGB(255, 55, 30, 70),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),

        borderSide: const BorderSide(color: Colors.white54),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  void _showProfileDialog(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Profile Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (user.email != null) Text('Email: ${user.email}'),
            if (!user.emailVerified)
              CustomButton(
                label: 'Verify Email',
                onPressed: () {
                  context.read<FirebaseAuthMethods>().sendEmailVerification(context);
                },
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(User? user) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 18, 6, 29),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 44, 1, 49),
                  Color.fromARGB(99, 89, 2, 97)
                ],
              ),
            ),
            child: Text('Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          _buildDrawerItem(icon: Icons.home, text: 'Home', screen: home.HomeScreen()),
          if (user != null)
            ExpansionTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text('Settings', style: TextStyle(color: Colors.white)),
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              children: [
                _buildDrawerItem(
                  icon: Icons.notifications_active,
                  text: 'Rate Alerts',
                  screen: const RateAlertsScreen(),
                ),
                _buildDrawerItem(
                  icon: Icons.trending_up,
                  text: 'Currency News',
                  screen: const CurrencyNewsScreen(),
                ),
                _buildDrawerItem(
                  icon: Icons.support_agent,
                  text: 'Help Center',
                  screen: const HelpCenterScreen(),
                ),
                _buildDrawerItem(
                  icon: Icons.history,
                  text: 'Conversion History',
                  screen: const ConversionHistoryScreen(),
                ),
                _buildDrawerItem(
                  icon: Icons.currency_exchange,
                  text: 'Default Currency',
                  screen: const DefaultCurrencyScreen(),
                ),
              ],
            ),
          _buildDrawerItem(
            icon: Icons.reviews,
            text: 'Testimonial',
            screen: const TestimonialPage(),
          ),
          _buildDrawerItem(
            icon: Icons.contact_page,
            text: 'Contact',
            screen: const ContactPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String text, required Widget screen}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
    );
  }
}
