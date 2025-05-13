import 'package:cricket_card_game/player/player.dart';

class HumanPlayer extends Player {
  HumanPlayer(super.name);

  @override 
  Card playCard() {
    return cards.removeAt(0);
  } 
} 