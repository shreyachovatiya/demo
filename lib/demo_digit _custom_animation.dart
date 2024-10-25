// import 'dart:math';
//
// import 'package:animated_digit/animated_digit.dart';
// import 'package:flutter/material.dart';
//
// class DemoDigitCustomAnimation extends StatefulWidget {
//   const DemoDigitCustomAnimation({super.key});
//
//   @override
//   State<DemoDigitCustomAnimation> createState() =>
//       _DemoDigitCustomAnimationState();
// }
//
// class _DemoDigitCustomAnimationState extends State<DemoDigitCustomAnimation> {
//   final AnimatedDigitController animatedDigitController =
//       AnimatedDigitController(1);
//   int textScaleFactor = 1;
//
//   void add() {
//     animatedDigitController.addValue(Random().nextInt(DateTime.now().year + 1));
//     debugPrint(
//         "Random().nextInt(DateTime.now()===================${Random().nextInt(DateTime.now().year + 1)}");
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: FloatingActionButton(
//         elevation: 0,
//         backgroundColor: Colors.black,
//         shape: const CircleBorder(),
//         onPressed: () {
//           add();
//         },
//         child: const Icon(
//           Icons.add,
//           color: Colors.white,
//           size: 25,
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: Container(
//               height: 130,
//               width: 360,
//               decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: Colors.green, width: 8)),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     const Text(
//                       '\$',
//                       style: TextStyle(color: Colors.white, fontSize: 50),
//                     ),
//                     const VerticalDivider(
//                       color: Colors.white,
//                       thickness: 3,
//                     ),
//                     Text(
//                       animatedDigitController.value.toStringAsFixed(1),
//                       style: const TextStyle(color: Colors.white, fontSize: 50),
//                     ),
//                     const VerticalDivider(
//                       color: Colors.white,
//                       thickness: 3,
//                     ),
//                     const Text(
//                       '2',
//                       style: TextStyle(color: Colors.white, fontSize: 50),
//                     ),
//                     const VerticalDivider(
//                       color: Colors.white,
//                       thickness: 3,
//                     ),
//                     const Text(
//                       '5',
//                       style: TextStyle(color: Colors.white, fontSize: 50),
//                     ),
//                     const VerticalDivider(
//                       color: Colors.white,
//                       thickness: 3,
//                     ),
//                     const Text(
//                       '8',
//                       style: TextStyle(color: Colors.white, fontSize: 50),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:math';

import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';

class DemoDigitCustomAnimation extends StatefulWidget {
  const DemoDigitCustomAnimation({super.key});

  @override
  State<DemoDigitCustomAnimation> createState() =>
      _DemoDigitCustomAnimationState();
}

class _DemoDigitCustomAnimationState extends State<DemoDigitCustomAnimation> {
  final AnimatedDigitController animatedDigitController =
      AnimatedDigitController(1000);
  void add() {
    animatedDigitController.addValue(Random().nextInt(9999 - 1000) + 1000);
    debugPrint(
        "Random().nextInt(9999 - 1000) + 1000===================${Random().nextInt(9999 - 1000) + 1000}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final String number =
        animatedDigitController.value.toString().padLeft(4, '0');
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        onPressed: () {
          add();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 130,
              width: 360,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green, width: 8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      '\$',
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                    const VerticalDivider(
                      color: Colors.white,
                      thickness: 3,
                    ),
                    ...number.characters.map((digit) {
                      return Row(
                        children: [
                          AnimatedDigitWidget(
                            controller:
                                AnimatedDigitController(int.parse(digit)),
                            textStyle: const TextStyle(
                                color: Colors.white, fontSize: 50),
                            fractionDigits: 0,
                            enableSeparator: false,
                          ),
                          const VerticalDivider(
                            color: Colors.white,
                            thickness: 3,
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
