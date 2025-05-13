import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_demo/screens/contact_screen.dart';
import 'package:firebase_auth_demo/screens/customfooter.dart';
import 'package:firebase_auth_demo/screens/login_email_password_screen.dart';
import 'package:firebase_auth_demo/screens/login_screen.dart';
import 'package:firebase_auth_demo/screens/signup_email_password_screen.dart';
import 'package:firebase_auth_demo/screens/testimonial_page_screen.dart';
import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';
import 'package:firebase_auth_demo/widgets/BottomRateAlerts.dart';
import 'package:firebase_auth_demo/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/saved_conversions_model.dart';
import '../screens/conversion_history_screen.dart';
import '../screens/default_currency_screen.dart';
import '../screens/rate_alerts_screen.dart';
import '../screens/currency_news_screen.dart';
import '../screens/help_center_screen.dart';
import 'package:firebase_auth_demo/widgets/page_with_loader.dart';

// Custom Button Widget
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Set your button color here
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(label),
    );
  }
}

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

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
  String? _userId;
  bool _isLoading = true;
  final int _itemsPerPage = 3; // Adjust based on your layout
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _userId = FirebaseAuth.instance.currentUser?.uid;
    _loadUserSettings();
    _listenToCurrencyChanges();
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false); // ✅ Safe now
      }
    });
  }

  void _listenToCurrencyChanges() {
    if (_userId != null) {
      FirebaseFirestore.instance
          .collection('app_settings')
          .doc(_userId)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>?;

          if (data != null) {
            final newCurrency = data['defaultCurrency'] ?? 'USD';
            if (newCurrency != _defaultCurrency) {
              setState(() {
                _defaultCurrency = newCurrency;
                _selectedCurrency = newCurrency;
                _exchangeRate =
                    _getExchangeRate(_defaultCurrency, _selectedCurrency);
              });
            }
          }
        }
      });
    }
  }

  void _loadUserSettings() async {
    if (_userId != null) {
      final doc = await FirebaseFirestore.instance
          .collection('app_settings')
          .doc(_userId)
          .get();
      if (doc.exists) {
        final settings = doc.data()?['settings'] ?? {};
        setState(() {
          _defaultCurrency = settings['defaultCurrency'] ?? 'PKR';
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
    // Check if the user is logged in (userId is not null)
    if (_userId == null) {
      // If userId is null, navigate to the login screen
      Navigator.pushNamed(context, EmailPasswordLogin.routeName);
      return; // Return early to stop further execution
    }

    // Proceed with saving the conversion
    final double sendAmount = double.tryParse(_sendController.text) ?? 0.0;
    if (sendAmount == 0.0) {
      _showErrorAlert('Please enter an amount greater than 0.');
      return;
    }

    final double receiveAmount = sendAmount * _exchangeRate;

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
      originalAmount: sendAmount,
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

  Widget _buildConversionBox() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 26, 5, 19),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 250, 250, 250),
            blurRadius: 12,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Currency Exchange',
              style: TextStyle(fontSize: 22, color: Colors.white)),
          const SizedBox(height: 8),
          Text('You have set $_defaultCurrency as your default currency.',
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic)),
          const SizedBox(height: 16),
          const Text('Amount',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 4),
          TextFormField(
            controller: _sendController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Enter amount',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButton<String>(
            dropdownColor: const Color.fromARGB(255, 45, 20, 55),
            value: _selectedCurrency,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedCurrency = value;
                  _exchangeRate =
                      _getExchangeRate(_defaultCurrency, _selectedCurrency);
                });
              }
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
                child: Text(currency,
                    style: TextStyle(
                      color: currency == _defaultCurrency
                          ? Colors.white
                          : Colors.grey[300],
                    )),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 20, 0, 11),
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
          const SizedBox(height: 16),

          // Row(
          //   children: [
          //     CustomButton(
          //       label: 'Convert',
          //       onPressed: _convertCurrency,
          //     ),
          //     const SizedBox(width: 20),
          //     CustomButton(
          //       label: 'Save Conversion',
          //       onPressed: _saveConversion,
          //     ),
          //     const SizedBox(width: 20),
          //     CustomButton(
          //       label: 'Reset',
          //       onPressed: _resetConversion,
          //     ),
          //   ],
          // ),
          Row(
            children: [
              _buildActionButton('Convert', _convertCurrency,
                  const Color.fromARGB(255, 81, 0, 92)),
              const SizedBox(width: 8),
              _buildActionButton('Reset', _resetConversion,
                  const Color.fromARGB(255, 31, 27, 30)),
              const SizedBox(width: 8),
              _buildActionButton('Save', _saveConversion,
                  const Color.fromARGB(255, 56, 24, 53)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, VoidCallback onTap, Color color) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 6,
          shadowColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(text),
      ),
    );
  }

  // Widget _buildExchangeTable() {
  //   if (_userId == null) return const Center(child: Text(''));
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: FirebaseFirestore.instance
  //         .collection('saved_conversions')
  //         .where('userId', isEqualTo: _userId)
  //         .snapshots(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Center(child: CircularProgressIndicator());
  //       }
  //       if (snapshot.hasError) {
  //         return const Center(child: Text('Error loading data.'));
  //       }

  //       final conversions = snapshot.data?.docs
  //               .map((doc) =>
  //                   SavedConversion.fromMap(doc.data() as Map<String, dynamic>))
  //               .toList() ??
  //           [];

  //       return ListView.builder(
  //         shrinkWrap: true,
  //         itemCount: conversions.length,
  //         itemBuilder: (context, index) {
  //           final conversion = conversions[index];
  //           return ListTile(
  //             title: Text(
  //               '${conversion.convertedAmount} ${conversion.convertedCurrency}',
  //               style: const TextStyle(color: Colors.white),
  //             ),
  //             subtitle: Text(
  //               'From ${conversion.defaultCurrency} ${conversion.originalAmount}',
  //               style: const TextStyle(color: Colors.white70),
  //             ),
  //             trailing: Text(
  //               conversion.createdAt!.toDate().toString(),
  //               style: const TextStyle(color: Colors.white60),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return PageWithLoader(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 18, 6, 29),
          iconTheme: const IconThemeData(color: Colors.white),
          title: Row(
            children: [
              Image.asset(
                'assets/logo.png',
                height: 40,
              ),
              const SizedBox(width: 10),
              const Text(
                'Currency App',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.white),
              onPressed: () {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  _showProfileDialog(
                      context, user); // Show profile if logged in
                } else {
                  Navigator.pushNamed(
                      context,
                      EmailPasswordLogin
                          .routeName); // Show login screen if not logged in
                }
              },
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onSelected: (value) async {
                if (value == 'signout') {
                  await context.read<FirebaseAuthMethods>().signOut(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const EmailPasswordLogin()),
                    (route) => false,
                  );
                } else if (value == 'delete') {
                  await context
                      .read<FirebaseAuthMethods>()
                      .deleteAccount(context);
                } else if (value == 'signup') {
                  Navigator.pushNamed(
                      context,
                      EmailPasswordSignup
                          .routeName); // Navigate to signup screen
                } else if (value == 'login') {
                  Navigator.pushNamed(context,
                      EmailPasswordLogin.routeName); // Navigate to login screen
                }
              },
              itemBuilder: (context) {
                final user = FirebaseAuth.instance.currentUser;

                // If the user is not logged in, show login/signup options
                if (user == null) {
                  return [
                    const PopupMenuItem(
                        value: 'signup', child: Text('Sign Up')),
                    const PopupMenuItem(value: 'login', child: Text('Login')),
                  ];
                } else {
                  // If the user is logged in, show sign out/delete options
                  return const [
                    PopupMenuItem(value: 'signout', child: Text('Sign Out')),
                    PopupMenuItem(
                        value: 'delete', child: Text('Delete Account')),
                  ];
                }
              },
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 45, 20, 55),
        drawer: _buildDrawer(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildConversionBox(),
              // _buildExchangeTable(),
              const SizedBox(height: 24),
              const Divider(
                  thickness: 1, color: Color.fromARGB(60, 250, 248, 248)),
              const SizedBox(height: 12),
              const Text(
                "Live Rate Alerts", // Updated heading text
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22, // Increased font size for better readability
                  letterSpacing: 1.5, // Adds some spacing between letters
                ),
              ),
              const SizedBox(height: 8),
              const BottomRateAlerts(),
              const SizedBox(height: 24),

              const SizedBox(height: 8),

              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  return buildTestimonialsSection(constraints);
                },
              ),
              const CurrencyNewsScreen(),
              const SizedBox(height: 24),
              const Divider(
                  thickness: 1, color: Color.fromARGB(59, 243, 239, 239)),
              const SizedBox(height: 24),
              const CustomFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTestimonialsSection(BoxConstraints constraints) {
    // Responsive settings
    int crossAxisCount;
    if (constraints.maxWidth > 1200) {
      crossAxisCount = 4;
    } else if (constraints.maxWidth > 900) {
      crossAxisCount = 3;
    } else if (constraints.maxWidth > 600) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    final horizontalPadding = constraints.maxWidth * 0.05;
    final verticalPadding = constraints.maxWidth * 0.02;

    late double titleFontSize;
    late double cardHorizontalPadding;
    late double cardVerticalPadding;
    late double emailFontSize;
    late double messageFontSize;
    late double spacingBetween;

    if (constraints.maxWidth > 1200) {
      titleFontSize = constraints.maxWidth * 0.04;
      cardHorizontalPadding = constraints.maxWidth * 0.01;
      cardVerticalPadding = constraints.maxWidth * 0.010;
      emailFontSize = constraints.maxWidth * 0.017;
      messageFontSize = constraints.maxWidth * 0.01;
      spacingBetween = constraints.maxWidth * 0.01;
    } else if (constraints.maxWidth > 900) {
      titleFontSize = constraints.maxWidth * 0.02;
      cardHorizontalPadding = constraints.maxWidth * 0.01;
      cardVerticalPadding = constraints.maxWidth * 0.010;
      emailFontSize = constraints.maxWidth * 0.02;
      messageFontSize = constraints.maxWidth * 0.02;
      spacingBetween = constraints.maxWidth * 0.01;
    } else if (constraints.maxWidth > 600) {
      titleFontSize = constraints.maxWidth * 0.04;
      cardHorizontalPadding = constraints.maxWidth * 0.02;
      cardVerticalPadding = constraints.maxWidth * 0.015;
      emailFontSize = constraints.maxWidth * 0.04;
      messageFontSize = constraints.maxWidth * 0.03;
      spacingBetween = constraints.maxWidth * 0.01;
    } else {
      titleFontSize = constraints.maxWidth * 0.04;
      cardHorizontalPadding = constraints.maxWidth * 0.02;
      cardVerticalPadding = constraints.maxWidth * 0.015;
      emailFontSize = constraints.maxWidth * 0.05;
      messageFontSize = constraints.maxWidth * 0.04;
      spacingBetween = constraints.maxWidth * 0.01;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('contacts')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final allDocs = snapshot.data!.docs;
          if (allDocs.isEmpty) {
            return const Center(
                child: Text('No testimonials available.',
                    style: TextStyle(color: Colors.white)));
          }

          final currentDocs = allDocs.take(8).toList(); // Or paginate if needed

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Testimonials',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spacingBetween),
              const Divider(color: Colors.white70, thickness: 1),
              SizedBox(height: spacingBetween * 2),
              GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: spacingBetween * 4,
                mainAxisSpacing: spacingBetween * 4,
                childAspectRatio: constraints.maxWidth > 1200
                    ? 1.10
                    : constraints.maxWidth > 600
                        ? 0.9
                        : 1.8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: currentDocs.map((doc) {
                  final email = doc['email'] ?? 'No email';
                  final message = doc['message'] ?? 'No message';
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 30, 15, 40),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: cardHorizontalPadding,
                      vertical: cardVerticalPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          email,
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: emailFontSize,
                            letterSpacing: 1.0,
                          ),
                        ),
                        SizedBox(height: spacingBetween * 2),
                        Text(
                          message,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: messageFontSize,
                            height: 1.5,
                          ),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              // 👇 Your image section added below the testimonials
              SizedBox(height: spacingBetween * 4),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.9),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 400,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/curre.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 24,
                      top: 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Currency changes the way we trade.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: titleFontSize * 0.6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 43, 0, 36),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('See More'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDrawer() {
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
            title:
                const Text('Settings', style: TextStyle(color: Colors.white)),
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            children: [
              // Show "Rate Alerts," "Currency News," and "Help Center" if the user is logged out (user == null)
              if (FirebaseAuth.instance.currentUser == null ||
                  FirebaseAuth.instance.currentUser != null)
                _buildDrawerItem(
                  icon: Icons.notifications_active,
                  text: 'Rate Alerts',
                  screen: const RateAlertsScreen(),
                ),
              if (FirebaseAuth.instance.currentUser == null ||
                  FirebaseAuth.instance.currentUser != null)
                _buildDrawerItem(
                  icon: Icons.trending_up,
                  text: 'Currency News',
                  screen: const CurrencyNewsScreen(),
                ),
              if (FirebaseAuth.instance.currentUser == null ||
                  FirebaseAuth.instance.currentUser != null)
                _buildDrawerItem(
                  icon: Icons.support_agent,
                  text: 'Help Center',
                  screen: const HelpCenterScreen(),
                ),
              // Show "Conversion History" and "Default Currency" if the user is logged in (user != null)
              if (FirebaseAuth.instance.currentUser != null)
                _buildDrawerItem(
                  icon: Icons.history,
                  text: 'Conversion History',
                  screen: const ConversionHistoryScreen(),
                ),
              if (FirebaseAuth.instance.currentUser != null)
                _buildDrawerItem(
                  icon: Icons.currency_exchange,
                  text: 'Default Currency',
                  screen: const DefaultCurrencyScreen(),
                ),
            ],
          ),
          ListTile(
              leading: const Icon(Icons.info, color: Colors.white),
              title: const Text('Blog', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              }),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text('Testimonial',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const TestimonialPage()),
              );
            },
          ),
          ListTile(
              leading: const Icon(Icons.info, color: Colors.white),
              title:
                  const Text('Contact', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ContactPage()),
                );
              }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon, required String text, required Widget screen}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(text, style: const TextStyle(color: Colors.white70)),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
    );
  }

  void _showProfileDialog(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Profile Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!user.isAnonymous && user.phoneNumber == null)
                Text('Email: ${user.email}'),
              if (user.phoneNumber != null) Text('Phone: ${user.phoneNumber}'),
              // Text('UID: ${user.uid}'),
              if (!user.emailVerified && !user.isAnonymous)
                CustomButton(
                  label: 'Verify Email',
                  onPressed: () {
                    context
                        .read<FirebaseAuthMethods>()
                        .sendEmailVerification(context);
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
        );
      },
    );
  }
}
