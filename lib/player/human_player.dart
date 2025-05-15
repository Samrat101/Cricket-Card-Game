import 'package:cricket_card_game/interfaces/cricket_card_interface.dart';
import 'package:cricket_card_game/player/player.dart';

class HumanPlayer extends Player {
  HumanPlayer(super.name);

  @override 
  CricketCardInterface playCard() {
    return cards.firstWhere((card) => card.isSelected == true); 
  } 
} 