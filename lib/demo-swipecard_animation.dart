import 'package:flutter/material.dart';

class DemoSwipeCardAnimation extends StatefulWidget {
  const DemoSwipeCardAnimation({super.key});

  @override
  State<DemoSwipeCardAnimation> createState() => _DemoSwipeCardAnimationState();
}

class _DemoSwipeCardAnimationState extends State<DemoSwipeCardAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _swipeAnimation;
  double cardOffsetY = 100;
  int currentCardIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _swipeAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(2, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          currentCardIndex++;
          _controller.reset();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSwipe() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 150),
            Stack(
              clipBehavior: Clip.none,
              children: [
                if (currentCardIndex <= 3)
                  _buildCard(3, Colors.pink.shade100, 100, w),
                if (currentCardIndex <= 2)
                  _buildCard(2, Colors.pink.shade200, 70, w),
                if (currentCardIndex <= 1)
                  _buildCard(1, Colors.pink.shade300, 40, w),
                if (currentCardIndex <= 0)
                  _buildTopCard(Colors.pink.shade400, 0, w),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopCard(Color color, double top, double width) {
    return GestureDetector(
      onPanEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          _onSwipe();
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: _swipeAnimation.value * width,
            child: _buildCard(0, color, top, width),
          );
        },
      ),
    );
  }

  // Reusable card widget
  Widget _buildCard(int index, Color color, double top, double width) {
    return Positioned(
      top: top,
      child: Container(
        height: 250,
        width: width - 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
