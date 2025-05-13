import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_demo/screens/contact_screen.dart';
import 'package:firebase_auth_demo/screens/conversion_history_screen.dart';
import 'package:firebase_auth_demo/screens/currency_news_screen.dart';
import 'package:firebase_auth_demo/screens/customfooter.dart';
import 'package:firebase_auth_demo/screens/default_currency_screen.dart';
import 'package:firebase_auth_demo/screens/help_center_screen.dart';
import 'package:firebase_auth_demo/screens/home_screen.dart';
import 'package:firebase_auth_demo/screens/login_email_password_screen.dart';
import 'package:firebase_auth_demo/screens/rate_alerts_screen.dart';
import 'package:firebase_auth_demo/screens/signup_email_password_screen.dart';
import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestimonialPage extends StatefulWidget {
  const TestimonialPage({Key? key}) : super(key: key);

  @override
  State<TestimonialPage> createState() => _TestimonialPageState();
}

class _TestimonialPageState extends State<TestimonialPage> {
  int _currentPage = 0;
  final int _itemsPerPage = 3;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 45, 20, 55),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 6, 29),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Image.asset('assets/logo.png', height: 40),
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
                _showProfileDialog(context, user); // Show profile if logged in
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
                  MaterialPageRoute(builder: (_) => const EmailPasswordLogin()),
                  (route) => false,
                );
              } else if (value == 'delete') {
                await context
                    .read<FirebaseAuthMethods>()
                    .deleteAccount(context);
              } else if (value == 'signup') {
                Navigator.pushNamed(context,
                    EmailPasswordSignup.routeName); // Navigate to signup screen
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
                  const PopupMenuItem(value: 'signup', child: Text('Sign Up')),
                  const PopupMenuItem(value: 'login', child: Text('Login')),
                ];
              } else {
                // If the user is logged in, show sign out/delete options
                return const [
                  PopupMenuItem(value: 'signout', child: Text('Sign Out')),
                  PopupMenuItem(value: 'delete', child: Text('Delete Account')),
                ];
              }
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determine crossAxisCount based on available width
          int crossAxisCount;
          if (constraints.maxWidth > 1200) {
            crossAxisCount = 4; // For very wide desktops
          } else if (constraints.maxWidth > 900) {
            crossAxisCount = 3; // For standard desktops/large tablets
          } else if (constraints.maxWidth > 600) {
            crossAxisCount = 2; // For smaller tablets/larger phones
          } else {
            crossAxisCount = 1; // For phones
          }

          final horizontalPadding = constraints.maxWidth * 0.05;
          final verticalPadding = constraints.maxWidth *
              0.02; // Adjust vertical padding based on width

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

                final totalPages = (allDocs.length / _itemsPerPage).ceil();
                final currentDocs = allDocs
                    .skip(_currentPage * _itemsPerPage)
                    .take(_itemsPerPage)
                    .toList();

                return Column(
                  children: [
                    Text(
                      'Testimonials',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: spacingBetween),
                    const Divider(color: Colors.white70, thickness: 1),
                    SizedBox(height: spacingBetween * 2),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: spacingBetween * 4,
                        mainAxisSpacing: spacingBetween * 4,
                        childAspectRatio: constraints.maxWidth > 1200
                            ? 1.10
                            : constraints.maxWidth > 600
                                ? 0.9
                                : 1.8,
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
                                vertical: cardVerticalPadding),
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
                                SizedBox(height: spacingBetween * 3),
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
                    ),
                    SizedBox(height: spacingBetween * 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: _currentPage > 0
                              ? () => setState(() => _currentPage--)
                              : null,
                        ),
                        const SizedBox(width: 10),
                        Text('Page ${_currentPage + 1} of $totalPages',
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward,
                              color: Colors.white),
                          onPressed: (_currentPage + 1) < totalPages
                              ? () => setState(() => _currentPage++)
                              : null,
                        ),
                      ],
                    ),
                    SizedBox(height: spacingBetween),
                    const Divider(
                        thickness: 1, color: Color.fromARGB(59, 243, 239, 239)),
                    const CustomFooter(),
                  ],
                );
              },
            ),
          );
        },
      ),
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
              if (user.email != null) Text('Email: ${user.email}'),
              if (!user.emailVerified)
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<FirebaseAuthMethods>()
                        .sendEmailVerification(context);
                  },
                  child: const Text('Verify Email'),
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

  Widget _buildDrawer() {
    final user = FirebaseAuth.instance.currentUser;
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
                  Color.fromARGB(99, 89, 2, 97),
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
              if (user != null)
                _buildDrawerItem(
                  icon: Icons.history,
                  text: 'Conversion History',
                  screen: const ConversionHistoryScreen(),
                ),
              if (user != null)
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
            },
          ),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.white),
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
            leading: const Icon(Icons.contact_mail, color: Colors.white),
            title: const Text('Contact', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ContactPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required Widget screen,
  }) {
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
