// // import 'package:firebase_auth_demo/screens/home_screen.dart';
// // import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';
// // import 'package:firebase_auth_demo/widgets/custom_textfield.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';

// // class EmailPasswordLogin extends StatefulWidget {
// //   static String routeName = '/login-email-password';
// //   const EmailPasswordLogin({Key? key}) : super(key: key);

// //   @override
// //   _EmailPasswordLoginState createState() => _EmailPasswordLoginState();
// // }

// // class _EmailPasswordLoginState extends State<EmailPasswordLogin> {
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();

// //   void loginUser() async {
// //     try {
// //       await context.read<FirebaseAuthMethods>().loginWithEmail(
// //             email: emailController.text,
// //             password: passwordController.text,
// //             context: context,
// //           );

// //       Navigator.pushReplacement(
// //         context,
// //         MaterialPageRoute(builder: (context) => const HomeScreen()),
// //       );
// //     } catch (e) {
// //       print('Error during login: $e');
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Failed to login. Please try again.')),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final themeColor = const Color.fromARGB(255, 37, 0, 44);

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text(
// //           "Login",
// //           style: TextStyle(color: Colors.white),
// //         ),
// //         backgroundColor: themeColor,
// //         centerTitle: true,
// //         iconTheme: const IconThemeData(color: Colors.white),
// //       ),
// //       backgroundColor: Colors.grey[100],
// //       body: LayoutBuilder(
// //         builder: (context, constraints) {
// //           return SingleChildScrollView(
// //             child: ConstrainedBox(
// //               constraints: BoxConstraints(minHeight: constraints.maxHeight),
// //               child: Center(
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(16),
// //                   child: Card(
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(20),
// //                     ),
// //                     elevation: 10,
// //                     shadowColor: Colors.grey.withOpacity(0.5),
// //                     child: Container(
// //                       width: double.infinity,
// //                       constraints: const BoxConstraints(maxWidth: 400),
// //                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
// //                       decoration: BoxDecoration(
// //                         color: Colors.white,
// //                         borderRadius: BorderRadius.circular(15),
// //                         boxShadow: const [
// //                           BoxShadow(
// //                             color: Colors.black26,
// //                             blurRadius: 10,
// //                             spreadRadius: 2,
// //                             offset: Offset(2, 4),
// //                           ),
// //                         ],
// //                       ),
// //                       child: Column(
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: [
// //                           // Logo
// //                           Image.asset(
// //                             'assets/logoo.png',
// //                             height: 120,
// //                             width: 160,
// //                             fit: BoxFit.contain,
// //                           ),
// //                           const SizedBox(height: 20),

// //                           // Title
// //                           Text(
// //                             "Welcome Back",
// //                             style: TextStyle(
// //                               fontSize: 24,
// //                               fontWeight: FontWeight.bold,
// //                               color: themeColor,
// //                             ),
// //                           ),
// //                           const SizedBox(height: 30),

// //                           // Email
// //                           CustomTextField(
// //                             controller: emailController,
// //                             hintText: 'Enter your email',
// //                           ),
// //                           const SizedBox(height: 20),

// //                           // Password
// //                           CustomTextField(
// //                             controller: passwordController,
// //                             hintText: 'Enter your password',
// //                           ),
// //                           const SizedBox(height: 30),

// //                           // Button
// //                           SizedBox(
// //                             width: double.infinity,
// //                             child: ElevatedButton(
// //                               onPressed: loginUser,
// //                               style: ElevatedButton.styleFrom(
// //                                 backgroundColor: themeColor,
// //                                 padding: const EdgeInsets.symmetric(
// //                                   vertical: 14,
// //                                 ),
// //                                 shape: RoundedRectangleBorder(
// //                                   borderRadius: BorderRadius.circular(12),
// //                                 ),
// //                                 elevation: 4,
// //                               ),
// //                               child: const Text(
// //                                 "Login",
// //                                 style: TextStyle(
// //                                   color: Colors.white,
// //                                   fontSize: 16,
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:firebase_auth_demo/screens/home_screen.dart';
// import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';
// import 'package:firebase_auth_demo/widgets/custom_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final bool obscureText;
//   final Widget? suffixIcon;

//   const CustomTextField({
//     Key? key,
//     required this.controller,
//     required this.hintText,
//     this.obscureText = false, // Default value is false for email fields
//     this.suffixIcon,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       obscureText: obscureText, // To hide/show text
//       decoration: InputDecoration(
//         hintText: hintText,
//         suffixIcon: suffixIcon, // Optional icon for password field
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//     );
//   }
// }

// class EmailPasswordLogin extends StatefulWidget {
//   static String routeName = '/login-email-password';
//   const EmailPasswordLogin({Key? key}) : super(key: key);

//   @override
//   _EmailPasswordLoginState createState() => _EmailPasswordLoginState();
// }

// class _EmailPasswordLoginState extends State<EmailPasswordLogin> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   bool _obscureText = true; // For toggling password visibility

//   void loginUser() async {
//     try {
//       await context.read<FirebaseAuthMethods>().loginWithEmail(
//             email: emailController.text,
//             password: passwordController.text,
//             context: context,
//           );

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     } catch (e) {
//       print('Error during login: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to login. Please try again.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeColor = const Color.fromARGB(255, 37, 0, 44);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Login",
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: themeColor,
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       backgroundColor: Colors.grey[100],
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(minHeight: constraints.maxHeight),
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     elevation: 10,
//                     shadowColor: Colors.grey.withOpacity(0.5),
//                     child: Container(
//                       width: double.infinity,
//                       constraints: const BoxConstraints(maxWidth: 400),
//                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 10,
//                             spreadRadius: 2,
//                             offset: Offset(2, 4),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           // Logo
//                           Image.asset(
//                             'assets/logoo.png',
//                             height: 120,
//                             width: 160,
//                             fit: BoxFit.contain,
//                           ),
//                           const SizedBox(height: 20),

//                           // Title
//                           Text(
//                             "Welcome Back",
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: themeColor,
//                             ),
//                           ),
//                           const SizedBox(height: 30),

//                           // Email
//                           CustomTextField(
//                             controller: emailController,
//                             hintText: 'Enter your email',
//                             obscureText: false, // Email field does not need to be obscure
//                           ),
//                           const SizedBox(height: 20),

//                           // Password with eye icon
//                           CustomTextField(
//                             controller: passwordController,
//                             hintText: 'Enter your password',
//                             obscureText: _obscureText, // Toggle visibility
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _obscureText
//                                     ? Icons.visibility_off
//                                     : Icons.visibility,
//                                 color: Colors.grey,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _obscureText = !_obscureText; // Toggle visibility
//                                 });
//                               },
//                             ),
//                           ),
//                           const SizedBox(height: 30),

//                           // Login Button
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: loginUser,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: themeColor,
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 14,
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 elevation: 4,
//                               ),
//                               child: const Text(
//                                 "Login",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:firebase_auth_demo/screens/home_screen.dart';
import 'package:firebase_auth_demo/screens/phone_screen.dart';
import 'package:firebase_auth_demo/screens/signup_email_password_screen.dart';
import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';
import 'package:firebase_auth_demo/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false, // Default value is false for email fields
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText, // To hide/show text
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon, // Optional icon for password field
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class EmailPasswordLogin extends StatefulWidget {
  static String routeName = '/login-email-password';
  const EmailPasswordLogin({Key? key}) : super(key: key);

  @override
  _EmailPasswordLoginState createState() => _EmailPasswordLoginState();
}

class _EmailPasswordLoginState extends State<EmailPasswordLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscureText = true; // For toggling password visibility

  void loginUser() async {
    try {
      await context.read<FirebaseAuthMethods>().loginWithEmail(
            email: emailController.text,
            password: passwordController.text,
            context: context,
          );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      print('Error during login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to login. Please try again.')),
      );
    }
  }

  void goToSignupScreen() {
    // Navigate to Signup Screen
    Navigator.pushNamed(context, '/signup-email-password');
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color.fromARGB(255, 37, 0, 44);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: themeColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey[100],
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 400),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Logo
                          Image.asset(
                            'assets/logoo.png',
                            height: 120,
                            width: 160,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 20),

                          // Title
                          Text(
                            "Welcome Back",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: themeColor,
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Email
                          CustomTextField(
                            controller: emailController,
                            hintText: 'Enter your email',
                            obscureText:
                                false, // Email field does not need to be obscure
                          ),
                          const SizedBox(height: 20),

                          // Password with eye icon
                          CustomTextField(
                            controller: passwordController,
                            hintText: 'Enter your password',
                            obscureText: _obscureText, // Toggle visibility
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText =
                                      !_obscureText; // Toggle visibility
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: loginUser,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeColor,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // "Don't have an account?" link
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/signup-email-password');
                            },
                            child: const Text(
                              "Already have an account? Signup",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Login with Google button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context
                                    .read<FirebaseAuthMethods>()
                                    .signInWithGoogle(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 37, 0, 44),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                              ),
                              icon:
                                  const Icon(Icons.login, color: Colors.white),
                              label: const Text(
                                "Login with Google",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Login with Phone Number button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, PhoneScreen.routeName);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 37, 0, 44),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                              ),
                              icon:
                                  const Icon(Icons.phone, color: Colors.white),
                              label: const Text(
                                "Login with Phone Number",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
