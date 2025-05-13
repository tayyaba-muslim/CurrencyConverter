import 'package:firebase_auth_demo/screens/login_email_password_screen.dart';
import 'package:firebase_auth_demo/screens/phone_screen.dart';
import 'package:firebase_auth_demo/screens/signup_email_password_screen.dart';
import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';
import 'package:firebase_auth_demo/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  // static String routeName;

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

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
      onPressed: onPressed, // Correct usage of onPressed
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Set your button color here
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(label), // Display label on button
    );
  }
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomButton(
              label: 'Email/Password Sign Up', // Correct parameter
              onPressed: () {
                Navigator.pushNamed(context, EmailPasswordSignup.routeName);
              },
            ),
            CustomButton(
              label: 'Email/Password Login', // Correct parameter
              onPressed: () {
                Navigator.pushNamed(context, EmailPasswordLogin.routeName);
              },
            ),
            CustomButton(
              label: 'Phone Sign In', // Correct parameter
              onPressed: () {
                Navigator.pushNamed(context, PhoneScreen.routeName);
              },
            ),
            CustomButton(
              label: 'Google Sign In', // Correct parameter
              onPressed: () {
                context.read<FirebaseAuthMethods>().signInWithGoogle(context);
              },
            ),
            CustomButton(
              label: 'Facebook Sign In', // Correct parameter
              onPressed: () {
                context.read<FirebaseAuthMethods>().signInWithFacebook(context);
              },
            ),
            CustomButton(
              label: 'Anonymous Sign In', // Correct parameter
              onPressed: () {
                context.read<FirebaseAuthMethods>().signInAnonymously(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
