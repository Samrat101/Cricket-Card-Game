import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';

abstract class ComputerPlayerStrategy {
  CricketCardInterface playCard(List<CricketCardInterface> cards);
} 