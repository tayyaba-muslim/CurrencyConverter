import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_demo/screens/testimonial_page_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';

// Firebase options
import 'firebase_options.dart';

// Services and Providers
import 'services/firebase_auth_methods.dart';
import 'providers/user_provider.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/login_email_password_screen.dart';
import 'screens/signup_email_password_screen.dart';
import 'screens/phone_screen.dart';
import 'screens/conversion_history_screen.dart';
import 'screens/default_currency_screen.dart';
import 'screens/rate_alerts_screen.dart';
import 'screens/currency_news_screen.dart';
import 'screens/help_center_screen.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize FacebookAuth for Web
  if (kIsWeb) {
    FacebookAuth.i.webInitialize(
      appId: "1129634001214960", // Replace with your Facebook App ID
      cookie: true,
      xfbml: true,
      version: "v12.0",
    );
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );

  runApp(const MyApp());
}

extension on FacebookAuth {
  void webInitialize(
      {required String appId,
      required bool cookie,
      required bool xfbml,
      required String version}) {}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider<User?>(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Currency App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        // home: const AuthWrapper(),
        home: const HomeScreen(),
        routes: {
          EmailPasswordSignup.routeName: (context) =>
              const EmailPasswordSignup(),
          EmailPasswordLogin.routeName: (context) => const EmailPasswordLogin(),
          PhoneScreen.routeName: (context) => const PhoneScreen(),
          // New routes
          ConversionHistoryScreen.routeName: (context) =>
              const ConversionHistoryScreen(),
          DefaultCurrencyScreen.routeName: (context) =>
              const DefaultCurrencyScreen(),
          RateAlertsScreen.routeName: (context) => const RateAlertsScreen(),
          CurrencyNewsScreen.routeName: (context) => const CurrencyNewsScreen(),
          HelpCenterScreen.routeName: (context) => const HelpCenterScreen(),
          '/testimonials': (context) => const TestimonialPage(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const HomeScreen(); // Logged in
    }
    return const LoginScreen(); // Not logged in
  }
}
