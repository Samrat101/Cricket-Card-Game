import 'dart:async';
import 'package:cricket_card_game/cricket_card.dart';
import 'package:cricket_card_game/interfaces/cricket_card_interface.dart';
import 'package:cricket_card_game/player/player.dart';
import 'package:cricket_card_game/screens/filp_card.dart';
import 'package:cricket_card_game/seed_data/seed_data.dart';
import 'package:flutter/material.dart';

class CardGameScreen extends StatefulWidget {
  final Function onGameStart;
  final List<Player> players;
  const CardGameScreen(
      {super.key, required this.onGameStart, required this.players});

  @override
  State<CardGameScreen> createState() => _CardGameScreenState();
}

class _CardGameScreenState extends State<CardGameScreen> {
  List<CricketCardInterface> cards = [];
  final int totalCards = 20;
  final double cardWidth = 130;
  final double cardHeight = 160;
  final double spacingX = 12;
  final double spacingY = 16;
  bool _playTapped = false;
  late Offset centerOffset;
  late List<Offset> cardPositions;
  late List<GlobalKey<FlipCardState>> cardKeys;

  bool hasDistributed = false;
  @override
  void initState() {
    super.initState();
    startCardDistributionForPlayers();
  }

  void startCardDistributionForPlayers() {
    // Create and shuffle the cards
    final allCards = List<CricketCard>.from(
      SeedData.cardAttributes.map((e) => CricketCard.fromJson(e)),
    )..shuffle();

    // Calculate cards per player
    final players = widget.players;
    final cardsPerPlayer = allCards.length ~/ players.length;

    // Distribute cards to each player
    for (var i = 0; i < players.length; i++) {
      final start = i * cardsPerPlayer;
      final end = (i == players.length - 1)
          ? allCards.length
          : (i + 1) * cardsPerPlayer;
      final playerCards = allCards.sublist(start, end);
      players[i].dealCard(playerCards);
    }

    // Update the local cards list with all cards for UI purposes
    setState(() {
      cards = allCards;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenSize = MediaQuery.of(context).size;

    centerOffset = Offset(
      screenSize.width / 2 - cardWidth / 2,
      screenSize.height / 2 - cardHeight / 2,
    );

    cardPositions = List.generate(totalCards, (_) => centerOffset);
    cardKeys = List.generate(totalCards, (_) => GlobalKey<FlipCardState>());
  }

  void startDistribution() {
    if (hasDistributed) return;
    hasDistributed = true;

    final screenSize = MediaQuery.of(context).size;
    const leftStartX = 20.0;
    final rightStartX = screenSize.width - (4 * cardWidth + 3 * spacingX) - 20;
    final startY = screenSize.height / 2 - 1.5 * cardHeight;

    for (int i = 0; i < totalCards; i++) {
      final isPlayer1 = i % 2 == 0;
      final cardIndex = i ~/ 2;

      int row, col;
      if (cardIndex < 4) {
        row = 0;
        col = cardIndex;
      } else if (cardIndex < 8) {
        row = 1;
        col = cardIndex - 4;
      } else {
        row = 2;
        col = cardIndex - 8;
      }

      double xOffset;
      if (row < 2) {
        xOffset = (cardWidth + spacingX) * col;
      } else {
        double totalRowWidth = 2 * cardWidth + spacingX;
        xOffset = ((4 * cardWidth + 3 * spacingX) - totalRowWidth) / 2 +
            (cardWidth + spacingX) * col;
      }

      double dx = isPlayer1 ? leftStartX + xOffset : rightStartX + xOffset;
      double dy = startY + row * (cardHeight + spacingY);
      Offset target = Offset(dx, dy);

      Future.delayed(Duration(milliseconds: i * 100), () {
        setState(() {
          cardPositions[i] = target;
        });

        if (i == totalCards - 1) {
          // All cards distributed, flip all after short delay
          Future.delayed(const Duration(seconds: 1), () {
            for (var key in cardKeys) {
              key.currentState?.flip();
            }
          });
        }
      });
    }
    setState(() {
      _playTapped = true;
    });
    Future.delayed(const Duration(seconds: 4), () {
      widget.onGameStart();
    });
  }

  void startFlipAnimation() async {
    // Define anti-clockwise order (player 2 -> player 1 reverse)
    List<int> flipOrder = [];
    for (int i = totalCards - 1; i >= 0; i--) {
      flipOrder.add(i);
    }

    for (int i in flipOrder) {
      cardKeys[i].currentState?.flip();
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Cards
        ...List.generate(totalCards, (index) {
          return AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: cardPositions[index].dx,
            top: cardPositions[index].dy,
            child: FlipCard(
              key: cardKeys[index],
              width: cardWidth,
              height: cardHeight,
              frontText: 'Card ${index + 1}',
              backText: '🂠',
            ),
          );
        }),
        if (!_playTapped)
          Center(
            child: GestureDetector(
              onTap: startDistribution,
              child: Container(
                width: cardWidth,
                height: cardHeight,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[700],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Start Game',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
