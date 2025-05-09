// import 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//   const CustomButton({
//     Key? key,
//     required this.onTap,
//     required this.text, required String label, required void Function() onPressed,
//   }) : super(key: key);
//   final String text;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         minimumSize: const Size(double.infinity, 40),
//       ),
//       onPressed: onTap,
//       child: Text(text),
//     );
//   }
// }
import 'package:flutter/material.dart';

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
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 5,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
