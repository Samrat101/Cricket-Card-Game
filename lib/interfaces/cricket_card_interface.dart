import 'package:cricket_card_game/interfaces/card_attribute.dart';

abstract class CricketCardInterface {
  CardAttribute get runs;
  CardAttribute get matches;
  CardAttribute get centuries;
  CardAttribute get halfCenturies;
  CardAttribute get catches;
  CardAttribute get wickets;
  String get playerName;
  bool get isSelected;
  bool get canSelect;
   bool get isDiscarded;
  void updateCardStatus(bool status);
}
