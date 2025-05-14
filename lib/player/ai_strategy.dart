import 'package:cricket_card_game/player/computer_player_strategy.dart';
import 'package:cricket_card_game/player/player.dart';

class AIStrategy implements ComputerPlayerStrategy {
  @override
  CricketCard playCard(List<CricketCard> cards) {
    return cards[0]; 
  }
}