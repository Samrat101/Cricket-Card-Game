import 'package:cricket_card_game/player/player.dart';

abstract class ComputerPlayerStrategy {
  CricketCard playCard(List<CricketCard> cards);
} 