import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';
import 'package:firebase_auth_demo/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    print({user});
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.account_circle),
            onSelected: (value) {
              switch (value) {
                case 'profile':
                  // Navigate to Profile screen if needed
                  break;
                case 'signout':
                  context.read<FirebaseAuthMethods>().signOut(context);
                  break;
                case 'delete':
                  context.read<FirebaseAuthMethods>().deleteAccount(context);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'profile', child: Text('My Profile')),
              const PopupMenuItem(value: 'signout', child: Text('Sign Out')),
              const PopupMenuItem(
                  value: 'delete', child: Text('Delete Account')),
            ],
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Navigation',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Contact'),
            ),
          ],
        ),
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
    );
  }
}

// import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';
// import 'package:firebase_auth_demo/widgets/custom_button.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final user = context.read<FirebaseAuthMethods>().user;
//     if (user == null) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),  // Show loading spinner while user data is loading.
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         actions: [
//           PopupMenuButton<String>(  // Actions menu
//             icon: const Icon(Icons.account_circle),
//             onSelected: (value) {
//               switch (value) {
//                 case 'profile':
//                   break;
//                 case 'signout':
//                   context.read<FirebaseAuthMethods>().signOut(context);
//                   break;
//                 case 'delete':
//                   context.read<FirebaseAuthMethods>().deleteAccount(context);
//                   break;
//               }
//             },
//             itemBuilder: (context) => [
//               const PopupMenuItem(value: 'profile', child: Text('My Profile')),
//               const PopupMenuItem(value: 'signout', child: Text('Sign Out')),
//               const PopupMenuItem(value: 'delete', child: Text('Delete Account')),
//             ],
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Email: ${user.email ?? 'No email'}'),
//             Text('Provider: ${user.providerData.isNotEmpty ? user.providerData[0].providerId : 'No provider'}'),
//             Text('UID: ${user.uid}'),
//             const SizedBox(height: 16),
//             if (!user.emailVerified)
//               CustomButton(
//                 onTap: () {
//                   context.read<FirebaseAuthMethods>().sendEmailVerification(context);
//                 },
//                 text: 'Verify Email',
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
