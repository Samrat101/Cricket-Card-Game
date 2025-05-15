import 'dart:math';

import 'package:cricket_card_game/screens/start_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CricketCardGameApp());
}

class CricketCardGameApp extends StatelessWidget {
  const CricketCardGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cricket Card Game',
      theme: ThemeData(primarySwatch: Colors.green),
      home: GameStartScreen(),
    );
  }
}

class CardModel {
  final int wickets;
  final int runs;

  CardModel({required this.wickets, required this.runs});

  @override
  String toString() => 'W: $wickets, R: $runs';
}

class Player {
  final String name;
  List<CardModel> hand;
  CardModel? selectedCard;

  Player(this.name, this.hand);
}

class CricketCardGameScreen extends StatefulWidget {
  const CricketCardGameScreen({super.key});

  @override
  State<CricketCardGameScreen> createState() => _CricketCardGameScreenState();
}

class _CricketCardGameScreenState extends State<CricketCardGameScreen> {
  final int playerCount = 5; // Change this for more players
  List<Player> players = [];
  int currentLeaderIndex = 0;
  String? selectedAttribute;
  String? result;
  bool roundComplete = false;

  @override
  void initState() {
    super.initState();
    final deck = List.generate(
      playerCount * 5,
      (_) =>
          CardModel(wickets: Random().nextInt(6), runs: Random().nextInt(100)),
    );

    players = List.generate(playerCount, (i) {
      final hand = deck.sublist(i * 5, (i + 1) * 5);
      return Player('Player ${i + 1}', hand);
    });
  }

  bool get isGameOver => players.any((p) => p.hand.isEmpty);

  Player get currentLeader => players[currentLeaderIndex];

  bool allCardsSelected() {
    return players.every((p) => p.selectedCard != null);
  }

  void compareCards() {
    if (selectedAttribute == null || !allCardsSelected()) return;

    int bestValue = -1;
    List<Player> winners = [];

    for (var player in players) {
      int value = selectedAttribute == 'runs'
          ? player.selectedCard!.runs
          : player.selectedCard!.wickets;

      if (value > bestValue) {
        bestValue = value;
        winners = [player];
      } else if (value == bestValue) {
        winners.add(player);
      }
    }

    if (winners.length == 1) {
      result = '${winners.first.name} wins this round!';
    } else {
      result = 'It\'s a tie between: ${winners.map((w) => w.name).join(', ')}';
    }

    // Remove used cards
    for (var player in players) {
      player.hand.remove(player.selectedCard);
      player.selectedCard = null;
    }

    roundComplete = true;
    setState(() {});
  }

  void nextRound() {
    if (isGameOver) return;
    selectedAttribute = null;
    result = null;
    roundComplete = false;
    currentLeaderIndex = (currentLeaderIndex + 1) % players.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isGameOver) {
      return Scaffold(
        appBar: AppBar(title: const Text('Cricket Card Game')),
        body: const Center(
          child: Text('Game Over!', style: TextStyle(fontSize: 24)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Cricket Card Game')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Leader: ${currentLeader.name}'),
            const SizedBox(height: 10),
            if (selectedAttribute == null) buildAttributeSelector(),
            const SizedBox(height: 20),
            ...players.map((player) => buildPlayerCardRow(player)).toList(),
            const SizedBox(height: 20),
            if (result != null)
              Text(result!, style: const TextStyle(fontSize: 18)),
            if (roundComplete)
              ElevatedButton(
                onPressed: nextRound,
                child: const Text('Next Round'),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildPlayerCardRow(Player player) {
    bool isLeader = player == currentLeader;
    bool isTurnToSelect = (isLeader && selectedAttribute == null) ||
        (!isLeader && selectedAttribute != null && !roundComplete);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(player.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: player.hand.length,
            itemBuilder: (_, index) {
              final card = player.hand[index];
              final isSelected = player.selectedCard == card;
              return GestureDetector(
                onTap: isTurnToSelect
                    ? () {
                        setState(() {
                          player.selectedCard = card;
                          if (allCardsSelected()) {
                            compareCards();
                          }
                        });
                      }
                    : null,
                child: Card(
                  color: isSelected
                      ? Colors.green.shade200
                      : isTurnToSelect
                          ? Colors.white
                          : Colors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('W: ${card.wickets}'),
                        Text('R: ${card.runs}'),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildAttributeSelector() {
    return Column(
      children: [
        const Text('Leader, choose attribute:'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedAttribute = 'runs';
                });
              },
              child: const Text('Runs'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedAttribute = 'wickets';
                });
              },
              child: const Text('Wickets'),
            ),
          ],
        ),
      ],
    );
  }
}
