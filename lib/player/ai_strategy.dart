import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';
import 'package:cricket_card_game/player/computer_player_strategy.dart';

class AIStrategy implements ComputerPlayerStrategy {
  @override
  CricketCardInterface playCard(List<CricketCardInterface> cards) {
    return cards[0]; 
  }
}