// import 'package:firebase_auth_demo/screens/home_screen.dart';
// import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';
// import 'package:firebase_auth_demo/widgets/custom_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:firebase_auth_demo/screens/home_screen.dart';
import 'package:firebase_auth_demo/screens/phone_screen.dart';
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


// class EmailPasswordSignup extends StatefulWidget {
//   static String routeName = '/signup-email-password';
//   const EmailPasswordSignup({Key? key}) : super(key: key);

//   @override
//   _EmailPasswordSignupState createState() => _EmailPasswordSignupState();
// }

// class _EmailPasswordSignupState extends State<EmailPasswordSignup> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   void signUpUser() async {
//     await context.read<FirebaseAuthMethods>().signUpWithEmail(
//           email: emailController.text.trim(),
//           password: passwordController.text.trim(),
//           context: context,
//         );

//     if (context.read<FirebaseAuthMethods>().user != null) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeColor = const Color.fromARGB(255, 37, 0, 44);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Sign Up", style: TextStyle(color: Colors.white)),
//         backgroundColor: themeColor,
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Container(
//             width: double.infinity,
//             constraints: const BoxConstraints(maxWidth: 400),
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 10,
//                   spreadRadius: 2,
//                   offset: Offset(2, 4),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Transform.translate(
//                   offset: const Offset(0, -10),
//                   child: Image.asset(
//                     'assets/logoo.png',
//                     height: 120,
//                     width: 160,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Create Account",
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 CustomTextField(
//                   controller: emailController,
//                   hintText: 'Enter your email',
//                 ),
//                 const SizedBox(height: 20),
//                 CustomTextField(
//                   controller: passwordController,
//                   hintText: 'Enter your password',
//                 ),
//                 const SizedBox(height: 30),
//                 ElevatedButton(
//                   onPressed: signUpUser,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: themeColor,
//                     minimumSize: const Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Text(
//                     "Sign Up",
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       backgroundColor: const Color(0xFFF0F2F5),
//     );
//   }
// }

class EmailPasswordSignup extends StatefulWidget {
  static String routeName = '/signup-email-password';
  const EmailPasswordSignup({Key? key}) : super(key: key);

  @override
  _EmailPasswordSignupState createState() => _EmailPasswordSignupState();
}

class _EmailPasswordSignupState extends State<EmailPasswordSignup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  bool _obscureText = true; // Password visibility toggle

  void signUpUser() async {
    await context.read<FirebaseAuthMethods>().signUpWithEmail(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          context: context,
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
        );

    if (context.read<FirebaseAuthMethods>().user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color.fromARGB(255, 37, 0, 44);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up", style: TextStyle(color: Colors.white)),
        backgroundColor: themeColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                Transform.translate(
                  offset: const Offset(0, -10),
                  child: Image.asset(
                    'assets/logoo.png',
                    height: 120,
                    width: 160,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                // First Name Field
                CustomTextField(
                  controller: firstNameController,
                  hintText: 'Enter your first name',
                ),
                const SizedBox(height: 20),
                // Last Name Field
                CustomTextField(
                  controller: lastNameController,
                  hintText: 'Enter your last name',
                ),
                const SizedBox(height: 20),
                // Email Field
                CustomTextField(
                  controller: emailController,
                  hintText: 'Enter your email',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                // Password Field
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Enter your password',
                  obscureText: _obscureText,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 30),
                // Sign Up Button
                ElevatedButton(
                  onPressed: signUpUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                // Login Button
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, '/login-email-password');
                  },
                  child: const Text(
                    "Already have an account? Login",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
            //     const SizedBox(height: 20),
            //     // Login with Google Button
            //     CustomButton(
            //       label: 'Login with Google',
            //       onPressed: () {
            //         context.read<FirebaseAuthMethods>().signInWithGoogle(context);
            //       },
            //     ),
            //     const SizedBox(height: 10),
            //     // Login with Phone Button
            //      CustomButton(
            //   label: 'Phone Sign In', // Correct parameter
            //   onPressed: () {
            //     Navigator.pushNamed(context, PhoneScreen.routeName);
            //   },
            // ),
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
                                backgroundColor: Colors.red,
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
                                backgroundColor: Colors.blueAccent,
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
                // CustomButton(
                //   label: 'Login with Phone Number',
                //   onPressed: () {
                //     Navigator.pushNamed(context, '/phone-signup');
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF0F2F5),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 37, 0, 44),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
