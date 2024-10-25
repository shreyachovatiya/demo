// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
//
// class ImageAnimationScreen extends StatefulWidget {
//   const ImageAnimationScreen({super.key});
//
//   @override
//   ImageAnimationScreenState createState() => ImageAnimationScreenState();
// }
//
// class ImageAnimationScreenState extends State<ImageAnimationScreen> {
//   int currentImageIndex = -1;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     Timer.periodic(const Duration(milliseconds: 500), (timer) {
//       if (currentImageIndex < 7) {
//         setState(() {
//           currentImageIndex++;
//         });
//       } else {
//         timer.cancel();
//       }
//     });
//     isLoading = true;
//     Future.delayed(const Duration(seconds: 4)).then(
//       (value) {
//         isLoading = false;
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Transform.rotate(
//             angle: 56,
//             child: Container(
//               height: size.height * 0.3,
//               width: size.width,
//               margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 40),
//               // color: Colors.red,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   for (int i = 0; i < 7; i++)
//                     buildAnimatedContainer(i, currentImageIndex >= i),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 40),
//           const Text(
//             "Let’s Find Your Sweet & Dream Place",
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             "Get the opportunity to stay that you dream\nof at an affordable price",
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.grey),
//           ),
//           const SizedBox(height: 20),
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.circle, size: 10, color: Colors.blue),
//               SizedBox(width: 5),
//               Icon(Icons.circle, size: 10, color: Colors.grey),
//               SizedBox(width: 5),
//               Icon(Icons.circle, size: 10, color: Colors.grey),
//             ],
//           ),
//           const SizedBox(height: 40),
//           isLoading == true
//               ? LoadingAnimationWidget.fourRotatingDots(
//                   color: Colors.blue,
//                   size: 50,
//                 )
//               : ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 100, vertical: 15),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30)),
//                       backgroundColor: Colors.blue),
//                   child: const Text(
//                     "Let's Go",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildAnimatedContainer(int index, bool isVisible) {
//     List<Offset> positions = [
//       const Offset(-0.5, -1), // Row 1, 1st image
//       const Offset(0.5, -1), // Row 1, 2nd image
//       const Offset(-1, 0), // Row 2, 1st image
//       const Offset(0, 0), // Row 2, 2nd image
//       const Offset(1, 0), // Row 2, 3rd image
//       const Offset(-0.5, 1), // Row 3, 1st image
//       const Offset(0.5, 1), // Row 3, 2nd image
//     ];
//     List<String> images = [
//       'assets/images/unsplash_VGtMvqHDpFw.png',
//       'assets/images/unsplash_VGtMvqHDpFw.png',
//       'assets/images/unsplash_VGtMvqHDpFw.png',
//       'assets/images/unsplash_VGtMvqHDpFw.png',
//       'assets/images/unsplash_VGtMvqHDpFw.png',
//       'assets/images/unsplash_VGtMvqHDpFw.png',
//       'assets/images/unsplash_VGtMvqHDpFw.png',
//     ];
//     return AnimatedAlign(
//       alignment: Alignment(positions[index].dx, positions[index].dy),
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//       child: AnimatedOpacity(
//         opacity: isVisible ? 1.0 : 0.0,
//         duration: const Duration(milliseconds: 500),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(18),
//           child: Image.asset(
//             images[index],
//             width: 80,
//             height: 80,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:math';

import 'package:flutter/material.dart';

class ComplexAnimationDemo extends StatefulWidget {
  const ComplexAnimationDemo({super.key});

  @override
  ComplexAnimationDemoState createState() => ComplexAnimationDemoState();
}

class ComplexAnimationDemoState extends State<ComplexAnimationDemo>
    with TickerProviderStateMixin {
  //SingleTickerProviderStateMixin

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);

    Future.delayed(const Duration(seconds: 13), () {
      _controller.stop();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.rotate(
                angle: _rotationAnimation.value,
                child: Opacity(
                  opacity: _fadeAnimation.value,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage(
                              'assets/images/unsplash_VGtMvqHDpFw.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
