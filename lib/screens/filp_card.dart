import 'dart:math';
import 'package:flutter/material.dart';

class FlipCard extends StatefulWidget {
  final double width;
  final double height;
  final String frontText;
  final String backText;

  const FlipCard({
    super.key,
    required this.width,
    required this.height,
    required this.frontText,
    required this.backText,
  });

  @override
  State<FlipCard> createState() => FlipCardState();
}

class FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isFront = !_isFront;
        _controller.reset();
      }
    });
  }

  void flip() {
    if (!_controller.isAnimating) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) {
        final isHalfWay = _animation.value >= pi / 2;
        final displayText = isHalfWay ? widget.backText : widget.frontText;
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(_animation.value),
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black87, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: _isFront
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Name',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          Text(
                            'Catches: ',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Centuries: ',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Half Centuries: ',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Matched: ',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Runs: ',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Wickets: ',
                            style: const TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
