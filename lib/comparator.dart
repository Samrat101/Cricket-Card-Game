import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/interfaces/card_attribute.dart';

extension AttributeComparator on CardAttribute {
  ComparisonOutcome compare(CardAttribute otherPlayerAttribute) {
    // compare card value
    final result = value.compareTo(otherPlayerAttribute.value);
    if (result == 0) {
      return ComparisonOutcome.tie;
    }
    switch (comparisionType) {
      case ComparisionWin.lower:
        return result < 0 ? ComparisonOutcome.win : ComparisonOutcome.loss;
      case ComparisionWin.greater:
        return result > 0 ? ComparisonOutcome.win : ComparisonOutcome.loss;
    }
  }
}
