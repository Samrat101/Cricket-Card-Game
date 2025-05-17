// ignore_for_file: unnecessary_getters_setters

import 'package:cricket_card_game/interfaces/card/card_attribute.dart';
import 'package:cricket_card_game/interfaces/card/card_interface.dart';

abstract class CricketCardInterface implements CardInterface {
  CardAttribute get runs;
  CardAttribute get matches;
  CardAttribute get centuries;
  CardAttribute get halfCenturies;
  CardAttribute get catches;
  CardAttribute get wickets;
  String get playerName;
  @override
  bool get isSelected;
  @override
  bool get canSelect;
  @override
  bool get isDiscarded;
  @override
  set canSelect(bool value);
  @override
  set isDiscarded(bool value);
  @override
  void updateCardSelectedStatus(bool status);
  @override
  CardAttribute getAttribute({required String withValue});
}
