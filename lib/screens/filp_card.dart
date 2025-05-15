import 'dart:math';
import 'package:cricket_card_game/interfaces/cricket_card_interface.dart';
import 'package:flutter/material.dart';

class FlipCard extends StatefulWidget {
  final CricketCardInterface card;
  final double width;
  final double height;
  final String frontText;
  final String backText;
  final Function(CricketCardInterface) cardSeletedCallback;

  const FlipCard(
      {super.key,
      required this.card,
      required this.width,
      required this.height,
      required this.frontText,
      required this.backText,
      required this.cardSeletedCallback});

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
        return GestureDetector(
          onTap: () {
            if (widget.card.canSelect) {
              widget.card.updateCardStatus(!widget.card.isSelected);
              widget.cardSeletedCallback(widget.card);
            }
            setState(() {});
          },
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_animation.value),
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.card.isSelected
                    ? Colors.green
                    : widget.card.canSelect
                        ? Colors.white
                        : Colors.grey,
                border: Border.all(color: Colors.black87, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _isFront
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                widget.card.playerName,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Text(
                              'Catches: ${widget.card.catches.value}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Centuries: ${widget.card.centuries.value}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Half Centuries: ${widget.card.halfCenturies.value}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Matched: ${widget.card.matches.value}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Runs: ${widget.card.runs.value}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              'Wickets: ${widget.card.wickets.value}',
                              style: const TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
