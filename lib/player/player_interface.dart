import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/interfaces/card/card_attribute.dart';
import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';

abstract class PlayerInterface {
  String get name;
  bool get isTurnActive;
  double get health;
  List<CricketCardInterface> get cards;
  SpecialMode? get specialMode;
  bool get isSpecialModeActive;
  bool get didUseSpecialMode;
  CricketCardInterface? get currentCard;
  CardAttribute? get selectedAttribute;

  set cards(List<CricketCardInterface> cards);
  set specialMode(SpecialMode? mode);
  set isSpecialModeActive(bool value);
  set didUseSpecialMode(bool value);
  set currentCard(CricketCardInterface? card);
  set selectedAttribute(CardAttribute? attribute);
  set isTurnActive(bool value);
  void updateHealth(double value);
  void toggleSpecialMode();
}