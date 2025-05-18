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
  String get id;
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

  @override
  bool operator==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CricketCardInterface) return false;
    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
