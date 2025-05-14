import 'package:cricket_card_game/cricket_card.dart';
import 'package:cricket_card_game/player/computer_player_strategy.dart';

class AIStrategy implements ComputerPlayerStrategy {
  @override
  CricketCard playCard(List<CricketCard> cards) {
    return cards[0]; 
  }
}