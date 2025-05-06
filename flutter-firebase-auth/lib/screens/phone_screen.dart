// // import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';
// // import 'package:firebase_auth_demo/widgets/custom_textfield.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:flutter/material.dart';

// // class CustomTextField extends StatelessWidget {
// //   final TextEditingController controller;
// //   final String hintText;
// //   final bool obscureText;
// //   final Widget? suffixIcon;

// //   const CustomTextField({
// //     Key? key,
// //     required this.controller,
// //     required this.hintText,
// //     this.obscureText = false, // Default value is false for email fields
// //     this.suffixIcon,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return TextField(
// //       controller: controller,
// //       obscureText: obscureText, // To hide/show text
// //       decoration: InputDecoration(
// //         hintText: hintText,
// //         suffixIcon: suffixIcon, // Optional icon for password field
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class PhoneScreen extends StatefulWidget {
// //   static String routeName = '/phone';
// //   const PhoneScreen({Key? key}) : super(key: key);

// //   @override
// //   State<PhoneScreen> createState() => _PhoneScreenState();
// // }

// // class _PhoneScreenState extends State<PhoneScreen> {
// //   final TextEditingController phoneController = TextEditingController();

// //   @override
// //   void dispose() {
// //     phoneController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final themeColor = const Color.fromARGB(255, 37, 0, 44);

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text(
// //           "Phone Sign In",
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
// //                       padding: const EdgeInsets.symmetric(
// //                         horizontal: 20,
// //                         vertical: 30,
// //                       ),
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
// //                           Image.asset(
// //                             'assets/logoo.png',
// //                             height: 120,
// //                             width: 160,
// //                             fit: BoxFit.contain,
// //                           ),
// //                           const SizedBox(height: 20),
// //                           Text(
// //                             "Enter Phone Number",
// //                             style: TextStyle(
// //                               fontSize: 24,
// //                               fontWeight: FontWeight.bold,
// //                               color: themeColor,
// //                             ),
// //                           ),
// //                           const SizedBox(height: 30),
// //                           CustomTextField(
// //                             controller: phoneController,
// //                             hintText: 'Enter phone number',
// //                           ),
// //                           const SizedBox(height: 30),
// //                           SizedBox(
// //                             width: double.infinity,
// //                             child: ElevatedButton(
// //                               onPressed: () {
// //                                 context
// //                                     .read<FirebaseAuthMethods>()
// //                                     .phoneSignIn(
// //                                       context,
// //                                       phoneController.text.trim(),
// //                                     );
// //                               },
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
// //                                 "OK",
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

// import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';
// import 'package:firebase_auth_demo/widgets/custom_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
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

// class PhoneScreen extends StatefulWidget {
//   static String routeName = '/phone';
//   const PhoneScreen({Key? key}) : super(key: key);

//   @override
//   State<PhoneScreen> createState() => _PhoneScreenState();
// }

// class _PhoneScreenState extends State<PhoneScreen> {
//   final TextEditingController phoneController = TextEditingController();

//   @override
//   void dispose() {
//     phoneController.dispose();
//     super.dispose();
//   }

//   // Function to validate the phone number format
//   bool isValidPhoneNumber(String phoneNumber) {
//     // Check if the phone number starts with a "+" and is followed by digits
//     return RegExp(r'^\+(\d{1,4})\d{7,15}$').hasMatch(phoneNumber);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeColor = const Color.fromARGB(255, 37, 0, 44);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Phone Sign In",
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
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 20,
//                         vertical: 30,
//                       ),
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
//                           Image.asset(
//                             'assets/logoo.png',
//                             height: 120,
//                             width: 160,
//                             fit: BoxFit.contain,
//                           ),
//                           const SizedBox(height: 20),
//                           Text(
//                             "Enter Phone Number",
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: themeColor,
//                             ),
//                           ),
//                           const SizedBox(height: 30),
//                           CustomTextField(
//                             controller: phoneController,
//                             hintText: 'Enter phone number',
//                           ),
//                           const SizedBox(height: 30),
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 final phoneNumber = phoneController.text.trim();

//                                 // Validate the phone number before proceeding
//                                 if (isValidPhoneNumber(phoneNumber)) {
//                                   context.read<FirebaseAuthMethods>().phoneSignIn(
//                                     context,
//                                     phoneNumber,
//                                   );
//                                 } else {
//                                   // Show an error if the phone number format is invalid
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                           'Invalid phone number format. Please use the international format.'),
//                                     ),
//                                   );
//                                 }
//                               },
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
//                                 "OK",
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
import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';
import 'package:firebase_auth_demo/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class PhoneScreen extends StatefulWidget {
  static String routeName = '/phone';
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  String verificationId = "";

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  // Function to validate the phone number format
  bool isValidPhoneNumber(String phoneNumber) {
    return RegExp(r'^\+(\d{1,4})\d{7,15}$').hasMatch(phoneNumber);
  }

  // Function to handle the phone number submission
  Future<void> _sendOTP() async {
    final phoneNumber = phoneController.text.trim();

    if (isValidPhoneNumber(phoneNumber)) {
      await context.read<FirebaseAuthMethods>().verifyPhoneNumber(
            phoneNumber,
            (String verId) {
              setState(() {
                verificationId = verId;
              });
              print("Verification ID: $verificationId");
            },
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid phone number format')),
      );
    }
  }

  // Function to handle OTP verification
  Future<void> _verifyOTP() async {
    final otp = otpController.text.trim();

    if (otp.isNotEmpty) {
      try {
        await context.read<FirebaseAuthMethods>().signInWithOTP(otp, verificationId);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP verification failed')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color.fromARGB(255, 37, 0, 44);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Sign In", style: TextStyle(color: Colors.white)),
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
                          Image.asset(
                            'assets/logoo.png',
                            height: 120,
                            width: 160,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Enter Phone Number",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: themeColor,
                            ),
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            controller: phoneController,
                            hintText: 'Enter phone number',
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _sendOTP,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeColor,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                              ),
                              child: const Text(
                                "Send OTP",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          // OTP Field
                          CustomTextField(
                            controller: otpController,
                            hintText: 'Enter OTP',
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _verifyOTP,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeColor,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                              ),
                              child: const Text(
                                "Verify OTP",
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
