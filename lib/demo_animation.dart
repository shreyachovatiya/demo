import 'package:flutter/material.dart';

class AnimationDemo extends StatefulWidget {
  const AnimationDemo({super.key});

  @override
  State<AnimationDemo> createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  AnimationController? _controller2;
  Animation<double>? _animation;
  Animation<double>? _animation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0.3, end: -0.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _controller?.forward();
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller2!,
        curve: Curves.easeInOut,
      ),
    );
    _controller2?.forward();
    Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation!,
              builder: (BuildContext context, Widget? child) {
                return Transform.translate(
                  offset: Offset(
                      MediaQuery.of(context).size.width * _animation!.value,
                      0.0),
                  child: GradientText(
                    'Hello',
                    style: const TextStyle(fontSize: 80),
                    gradient: LinearGradient(colors: [
                      Colors.blue.shade900,
                      Colors.blue.shade700,
                      Colors.blue.shade500,
                      Colors.blue.shade300,
                      Colors.blue.shade100,
                    ]),
                  ),
                );
              },
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.025),
            AnimatedBuilder(
              animation: _animation2!,
              builder: (BuildContext context, Widget? child) {
                return Opacity(
                  opacity: _animation2!.value,
                  child: GradientText(
                    'World',
                    style: const TextStyle(fontSize: 60),
                    gradient: LinearGradient(colors: [
                      Colors.pink.shade800,
                      Colors.pink.shade700,
                      Colors.pink.shade500,
                      Colors.pink.shade300,
                      Colors.pink.shade100,
                    ]),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTRB(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
