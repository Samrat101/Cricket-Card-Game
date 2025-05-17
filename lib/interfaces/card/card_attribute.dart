import 'package:cricket_card_game/enums.dart';

abstract class CardAttribute {
  final String code;
  final String description;
  final Comparable value;
  ComparisionWin get comparisionType;
  CardAttribute(
      {required this.code,
      required this.description,
      required this.value,
      required ComparisionWin comparisionType});
  void updateComparator(ComparisionWin newComparator);
}