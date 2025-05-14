import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/comparator.dart';

abstract class CardAttribute {
  String get code;
  String get description;
  Comparable get value;
  ComparisionWin comparisionType;
  CardAttribute({required this.comparisionType});

  void updateComparator(ComparisionWin newComparator) {
    comparisionType = newComparator;
  }
}
