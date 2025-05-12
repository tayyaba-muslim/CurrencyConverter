import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth_demo/screens/home_screen.dart' as home;
import 'package:firebase_auth_demo/screens/contact_screen.dart';
import 'package:firebase_auth_demo/screens/testimonial_page_screen.dart';
import 'package:firebase_auth_demo/screens/rate_alerts_screen.dart';

// 👇 Email launcher function (global)
void _launchEmail() async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'info@example.com',
    queryParameters: {
      'subject': 'Hello from the app',
      'body': 'I would like to contact you regarding...'
    },
  );

  if (await canLaunchUrl(emailLaunchUri)) {
    await launchUrl(emailLaunchUri);
  } else {
    throw 'Could not launch email';
  }
}

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        children: [
          // Top Row: Logo + Navigation
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.currency_exchange, color: Colors.white, size: 28),
                        SizedBox(width: 8),
                        Text(
                          "Currency",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: const [
                        _FooterLink(text: "Home", screen: home.HomeScreen()),
                        _FooterLink(text: "Contact", screen: ContactPage()),
                        _FooterLink(text: "Testimonials", screen: TestimonialPage()),
                        _FooterLink(text: "Rate Alerts", screen: RateAlertsScreen()),
                      ],
                    ),
                  ],
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.currency_exchange, color: Colors.white, size: 28),
                        SizedBox(width: 8),
                        Text(
                          "Currency",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        _FooterLink(text: "Home", screen: home.HomeScreen()),
                        _FooterLink(text: "Contact", screen: ContactPage()),
                        _FooterLink(text: "Testimonials", screen: TestimonialPage()),
                        _FooterLink(text: "Rate Alerts", screen: RateAlertsScreen()),
                      ],
                    ),
                  ],
                );
              }
            },
          ),

          const SizedBox(height: 20),
          const Divider(color: Colors.white30),
          const SizedBox(height: 15),

          // Bottom Row: Social Icons + Copyright
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const _SocialIcon(icon: Icons.facebook, url: "https://facebook.com"),
                        IconButton(
                          icon: const Icon(Icons.email, color: Colors.white),
                          onPressed: _launchEmail,
                        ),
                        const _SocialIcon(
                          icon: FontAwesomeIcons.google,
                          url: "https://www.google.com",
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "© 2025 Currency. All rights reserved.",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const _SocialIcon(icon: Icons.facebook, url: "https://facebook.com"),
                        IconButton(
                          icon: const Icon(Icons.email, color: Colors.white),
                          onPressed: _launchEmail,
                        ),
                        const _SocialIcon(
                          icon: FontAwesomeIcons.google,
                          url: "https://www.google.com",
                        ),
                      ],
                    ),
                    const Text(
                      "© 2025 Currency. All rights reserved.",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;
  final Widget? screen;

  const _FooterLink({required this.text, this.screen, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            if (screen != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => screen!),
              );
            }
          },
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const _SocialIcon({required this.icon, required this.url, Key? key}) : super(key: key);

  Future<void> _launchUrl(BuildContext context) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not launch $url")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: InkWell(
        onTap: () => _launchUrl(context),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }
}
