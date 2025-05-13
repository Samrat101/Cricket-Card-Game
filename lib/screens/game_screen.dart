import 'package:cricket_card_game/screens/cards_screen.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final List<String> names;
  const GameScreen({super.key, required this.names});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/game_screen.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(children: [
            const CardGameScreen(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.names
                  .map((name) => PlayerCard(playerName: name))
                  .toList(),
            ),
          ])),
    );
    ;
  }
}

class PlayerCard extends StatefulWidget {
  final String playerName;
  const PlayerCard({super.key, required this.playerName});

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  double _health = 1.0; // 100%

  void _changeHealth(double delta) {
    setState(() {
      _health = (_health + delta).clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.playerName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: _health,
                minHeight: 12,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
