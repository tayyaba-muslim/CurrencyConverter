import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.white), // 👈 White text color
        ),
        backgroundColor: const Color.fromARGB(255, 25, 20, 45),
        iconTheme: const IconThemeData(
            color: Colors.white), // 👈 back button icon bhi white
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!user.isAnonymous && user.phoneNumber == null)
              Text('Email: ${user.email!}'),
            if (!user.isAnonymous && user.phoneNumber == null)
              Text('Provider: ${user.providerData[0].providerId}'),
            if (user.phoneNumber != null) Text('Phone: ${user.phoneNumber!}'),
            Text('UID: ${user.uid}'),
            const SizedBox(height: 16),
            if (!user.emailVerified && !user.isAnonymous)
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
      ),
    );
  }
}
