import 'dart:math';

import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedDigitWidgetExample extends StatefulWidget {
  const AnimatedDigitWidgetExample({super.key});

  @override
  AnimatedDigitWidgetExampleState createState() =>
      AnimatedDigitWidgetExampleState();
}

class AnimatedDigitWidgetExampleState extends State<AnimatedDigitWidgetExample>
    with SingleTickerProviderStateMixin {
  final AnimatedDigitController animatedDigitController =
      AnimatedDigitController(111.987);
  double textScaleFactor = 1.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textScaleFactor = MediaQuery.textScaleFactorOf(context);
  }

  @override
  void dispose() {
    animatedDigitController.dispose();
    super.dispose();
  }

  void _add() {
    animatedDigitController.addValue(Random().nextInt(DateTime.now().year + 1));
    setState(() {});
  }

  void _remove() {
    animatedDigitController.minusValue(Random().nextInt(DateTime.now().year));
    setState(() {});
  }

  void _reset() {
    animatedDigitController.resetValue(0);
    setState(() {});
  }

  void updateFontScale() {
    setState(() {
      textScaleFactor = textScaleFactor == 1.0 ? 1.2 : 1.0;
    });
  }

  void _addDecimal() {
    var val = num.parse(Random().nextDouble().toStringAsFixed(2));
    animatedDigitController.addValue(val);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: false,
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ValueListenableBuilder(
              valueListenable: animatedDigitController,
              builder: (BuildContext context, num value, Widget? child) {
                return Text(
                  "current value:$value",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                const Text(
                  'Random Number',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                AnimatedDigitWidget(
                  key: const ValueKey("teal"),
                  value: Random().nextInt(DateTime.now().year),
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                )
              ],
            ),
            AnimatedDigitWidget(
              key: const Key("ads"),
              value: animatedDigitController.value,
              textStyle: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
              curve: Curves.easeOutCubic,
              enableSeparator: true,
              fractionDigits: 2,
              valueColors: [
                ValueColor(
                  condition: () => animatedDigitController.value <= 0,
                  color: Colors.red,
                ),
                ValueColor(
                  condition: () => animatedDigitController.value >= 1999,
                  color: Colors.orange,
                ),
                ValueColor(
                  condition: () => animatedDigitController.value >= 2999,
                  color: const Color.fromARGB(255, 247, 306, 24),
                ),
                ValueColor(
                  condition: () => animatedDigitController.value >= 3999,
                  color: Colors.green,
                ),
                ValueColor(
                  condition: () => animatedDigitController.value >= 4999,
                  color: Colors.cyan,
                ),
                ValueColor(
                  condition: () => animatedDigitController.value >= 5999,
                  color: Colors.blue,
                ),
                ValueColor(
                  condition: () => animatedDigitController.value >= 6999,
                  color: Colors.purple,
                ),
              ],
            ),
            const CupertinoTextField.borderless()
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: _add,
              child: const Icon(Icons.add),
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: updateFontScale,
              child: const Icon(Icons.font_download),
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: _reset,
              child: const Icon(Icons.restart_alt),
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: _remove,
              child: const Icon(Icons.remove),
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: _addDecimal,
              tooltip: "add decimal",
              child: const Icon(Icons.add_box_outlined),
            ),
          ],
        ),
      ),
      builder: (context, home) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(textScaleFactor)),
          child: home!,
        );
      },
    );
  }
}
