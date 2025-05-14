import 'package:cricket_card_game/cricket_card.dart';

abstract class ComputerPlayerStrategy {
  CricketCard playCard(List<CricketCard> cards);
} 