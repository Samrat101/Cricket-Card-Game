import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';
import 'package:cricket_card_game/player/computer_player_strategy.dart';
import 'package:cricket_card_game/player/player.dart';

class ComputerPlayer extends Player {
  final ComputerPlayerStrategy _strategy; 
ComputerPlayer(super.name, this._strategy);

@override 
CricketCardInterface playCard() {
  final selectedCard = _strategy.playCard(cards);  
  return selectedCard;
} 
} 