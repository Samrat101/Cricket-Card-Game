import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';
import 'package:cricket_card_game/player/battle.dart';
import 'package:cricket_card_game/player/player_interface.dart';
import 'package:cricket_card_game/screens/cards_screen.dart';
import 'package:cricket_card_game/screens/mode_selection.dart';
import 'package:cricket_card_game/screens/player_card.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final List<PlayerInterface> players;
  const GameScreen({super.key, required this.players});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Game game;
  bool canStartGame = false;
  bool gameStarted = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/game_screen.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(children: [
              CardGameScreen(
                  onGameStart: showModeSelectionDilog,
                  players: widget.players,
                  cardSeletedCallback: cardSeletedCallback),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: widget.players
                        .map((player) => PlayerCard(
                            player: player,
                            didChangeSpecialModeState: () {
                              final canChange =
                                  game.canChangeSpecialMode(player: player);
                              if (canChange) {
                                player.toggleSpecialMode();
                                return true;
                              }
                              return false;
                            }))
                        .toList(),
                  ),
                  if (canStartGame && !gameStarted)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(250, 60),
                            backgroundColor: Colors.white, // or any other color
                          ),
                          onPressed: () {
                            startGame();
                          },
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
                  if (gameStarted)
                    Container(
                      width: 300.0,
                      height: 500.0,
                      color: Colors.white,
                      child: game.isRoundLeaderCardSelected() &&
                              game.selectedAttribute == null
                          ? buildAttributeSelector()
                          : Center(
                              child: Text(
                                '${game.currentTurnPlayer.name} Please Select A Card',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                    )
                ],
              ),
            ])),
      ),
    );
  }

  void startGame() {
    game = Game(widget.players);
    game.start();
    gameStarted = true;
    setState(() {});
  }

  void cardSeletedCallback(CricketCardInterface card) {
    game.cardSelectedCallback(card);
    setState(() {});
  }

  void showModeSelectionDilog() async {
    await _showModeDialog();
    canStartGame = true;
    setState(() {});
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
        player.specialMode = mode;
        setState(() {});
      }
    }
  }

  Widget buildAttributeSelector() {
    List<String> attributes = [
      'runs',
      'wickets',
      'average',
      'strikeRate',
      'economyRate',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
            '${game.currentRoundLeader?.$1.name} Please select attribute to compare',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        ...attributes.map((attribute) => Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () {
                  game.attributeSelected(attribute);
                  setState(() {});
                },
                child: Text(attribute,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
            )),
      ],
    );
  }
}
