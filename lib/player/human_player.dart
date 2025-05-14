import 'package:cricket_card_game/player/player.dart';

class HumanPlayer extends Player {
  HumanPlayer(super.name);

  @override 
  CricketCard playCard() {
    return cards.firstWhere((card) => card.isSelected == true); 
  } 
} 