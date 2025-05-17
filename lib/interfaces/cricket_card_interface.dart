// ignore_for_file: unnecessary_getters_setters

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
  set isSelected(bool value);
  set canSelect(bool value);
  set isDiscarded(bool value);
  void updateCardStatus(bool status);
  CardAttribute getAttribute({required String withValue});
}
