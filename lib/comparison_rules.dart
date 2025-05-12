import 'package:cricket_card_game/enums.dart';

class GreaterComparisonRule {
  /// The result is always relative to the first attribute. If the first
  /// attribute is greater than the second attribute, the result is win.
  /// If the first attribute is less than the second attribute, the result
  /// is lose. If the first attribute is equal to the second attribute, the
  /// result is tie.
  ComparisionResult compareValues(
      {required Comparable attribute1, required Comparable attribute2}) {
    final value = attribute1.compareTo(attribute2);
    switch (value) {
      case 1:
        return ComparisionResult.win;
      case -1:
        return ComparisionResult.lose;
      case 0:
        return ComparisionResult.tie;
      default:
        throw Exception('Invalid comparison result');
    }
  }
}

class LowerComparisonRule {
  /// The result is always relative to the first attribute. If the first
  /// attribute is greater than the second attribute, the result is lose.
  /// If the first attribute is less than the second attribute, the result
  /// is win. If the first attribute is equal to the second attribute, the
  /// result is tie.
  ComparisionResult compareValues(
      {required Comparable attribute1, required Comparable attribute2}) {
    final value = attribute1.compareTo(attribute2);
    switch (value) {
      case 1:
        return ComparisionResult.lose;
      case -1:
        return ComparisionResult.win;
      case 0:
        return ComparisionResult.tie;
      default:
        throw Exception('Invalid comparison result');
    }
  }
}
