import 'package:cricket_card_game/player/human_player.dart';
import 'package:cricket_card_game/player/player.dart';
import 'package:cricket_card_game/screens/game_screen.dart';
import 'package:flutter/material.dart';

class GameStartScreen extends StatefulWidget {
  @override
  _GameStartScreenState createState() => _GameStartScreenState();
}

class _GameStartScreenState extends State<GameStartScreen> {
  int? _numPlayers;
  List<String> _playerNames = [];
  List<Player> _players = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/start_screen.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(250, 60),
            backgroundColor: Colors.white, // or any other color
          ),
          onPressed: _showNumberOfPlayersDialog,
          child: const Text(
            'Start Game',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ));
  }

  void _showNumberOfPlayersDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select number of players',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _playerCountTile(2),
              const SizedBox(height: 16),
              _playerCountTile(4),
            ],
          ),
        );
      },
    );
  }

  void _askPlayerName(int playerIndex) {
    TextEditingController controller = TextEditingController();
    controller.text = 'Player $playerIndex';
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Enter name for player $playerIndex',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Player $playerIndex Name'),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.text.trim().isEmpty) return;
              setState(() {
                _players.add(HumanPlayer(controller.text.trim())); 
                _playerNames[playerIndex - 1] = controller.text.trim();
              });
              Navigator.of(context).pop();
              if (playerIndex < (_numPlayers ?? 0)) {
                _askPlayerName(playerIndex + 1);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GameScreen(players: _players)),
                );
              }
            },
            child: const Text('Done',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
          ),
        ],
      ),
    );
  }

  Widget _playerCountTile(int count) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        _numPlayers = count;
        _playerNames = List.filled(count, '');
        _askPlayerName(1);
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
