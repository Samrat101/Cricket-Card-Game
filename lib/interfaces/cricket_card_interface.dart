import 'package:cricket_card_game/interfaces/card_attribute.dart';

abstract class CricketCardInterface {
  CardAttribute get runs;
  CardAttribute get matches;
  CardAttribute get centuries;
  CardAttribute get halfCenturies;
  CardAttribute get catches;
  CardAttribute get wickets;
  String get playerName;
  bool isSelected;
  bool canSelect;
  bool isDiscarded;
  void updateCardStatus(bool status);
  CardAttribute getAttribute({required String withValue});
  CricketCardInterface(
      {required this.isSelected,
      required this.canSelect,
      required this.isDiscarded});
}
