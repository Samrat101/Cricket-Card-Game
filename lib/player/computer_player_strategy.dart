import 'package:cricket_card_game/player/player.dart';

abstract class ComputerPlayerStrategy {
  Card playCard(List<Card> cards);
} 