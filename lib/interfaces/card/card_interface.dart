import 'package:cricket_card_game/interfaces/card/card_attribute.dart';

abstract class CardInterface {
  bool get isSelected;
  bool get canSelect;
  bool get isDiscarded;
  set canSelect(bool value);
  set isDiscarded(bool value);
  void updateCardSelectedStatus(bool status);
  CardAttribute getAttribute({required String withValue});
}