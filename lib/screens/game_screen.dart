import 'package:cricket_card_game/player/player.dart';
import 'package:cricket_card_game/screens/cards_screen.dart';
import 'package:cricket_card_game/screens/mode_selection.dart';
import 'package:flutter/material.dart';

enum SpecialMode {
  powerPlayMode('Power Play Mode'),
  superMode('Super Mode'),
  freeHitMode('Free Hit Mode');

  final String displayName;

  const SpecialMode(this.displayName);
}

SpecialMode? getSpecialModeFromString(String input) {
  for (var mode in SpecialMode.values) {
    if (mode.displayName.toLowerCase() == input.toLowerCase()) {
      return mode;
    }
  }
  return null; // or throw an error if you prefer
}

class GameScreen extends StatefulWidget {
  final List<Player> players;
  const GameScreen({super.key, required this.players});

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
            CardGameScreen(onGameStart: startGame),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: widget.players
                      .map((player) => PlayerCard(player: player))
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(250, 60),
                        backgroundColor: Colors.white, // or any other color
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Start Game',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ])),
    );
  }

  void startGame() async {
    await _showModeDialog();
    print('Starting game...');
  }

  _showModeDialog() async {
    for (final player in widget.players) {
      final selectedValue = await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (context) => ModeDialog(player: player),
      );
      if (selectedValue != null) {
        SpecialMode mode = getSpecialModeFromString(selectedValue)!;
        player.updateSpecialMode(mode);
        setState(() {});
      }
    }
  }

  Widget _playerCountTile(int count) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            '$count Players',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class PlayerCard extends StatefulWidget {
  final Player player;
  const PlayerCard({super.key, required this.player});

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
            Text(widget.player.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            if (widget.player.specialMode != null)
              Row(
                children: [
                  Text(widget.player.specialMode!.displayName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      if (widget.player.specialModeActive) {
                        widget.player.deActivateSpecialMode();
                      } else {
                        widget.player.activateSpecialMode();
                      }
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            widget.player.specialModeActive
                                ? 'Deactivate'
                                : 'Activate',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
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
