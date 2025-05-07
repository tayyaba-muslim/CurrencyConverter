// import 'package:flutter/material.dart';

// class PageWithLoader extends StatefulWidget {
//   final Widget child;

//   const PageWithLoader({super.key, required this.child, required bool isLoading});

//   @override
//   State<PageWithLoader> createState() => _PageWithLoaderState();
// }

// class _PageWithLoaderState extends State<PageWithLoader> with SingleTickerProviderStateMixin {
//   bool _isLoading = true;
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..repeat();

//     Future.delayed(const Duration(seconds: 2), () {
//       if (mounted) {
//         setState(() => _isLoading = false);
//         _controller.stop();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return Center(
//         child: RotationTransition(
//           turns: _controller,
//           child: Image.asset('assets/logoo.png', height: 100, width: 100),
//         ),
//       );
//     }
//     return widget.child;
//   }
// }
import 'dart:ui';
import 'package:flutter/material.dart';

class PageWithLoader extends StatefulWidget {
  final Widget child;
  final bool isLoading;

  const PageWithLoader({super.key, required this.child, required this.isLoading});

  @override
  State<PageWithLoader> createState() => _PageWithLoaderState();
}

class _PageWithLoaderState extends State<PageWithLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.isLoading)
          Positioned.fill(
            child: Stack(
              children: [
                // Blur and white overlay
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.white.withOpacity(0.6), // whitish background
                  ),
                ),
                Center(
                  child: RotationTransition(
                    turns: _controller,
                    child: Image.asset('assets/logoo.png', height: 100, width: 100),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
