import 'package:cricket_card_game/comparison_rules.dart';
import 'package:cricket_card_game/interfaces/cricket_card_interface.dart';
import 'package:cricket_card_game/enums.dart';

//MARK: Rules
/// The base class for all cricket card comparison rules.
/// This class is used to compare two cricket cards based on different criteria.
abstract class CricketCardComparisonRule {
  factory CricketCardComparisonRule(
      {required CricketCardComparisonRuleType ruleType}) {
    // no rule should be skipped or ignored. Create a rule for each type
    switch (ruleType) {
      case CricketCardComparisonRuleType.greaterRuns:
        return GreaterRunsRule();
      case CricketCardComparisonRuleType.greaterMatches:
        return GreaterMatchesRule();
      case CricketCardComparisonRuleType.greaterCenturies:
        return GreaterCenturiesRule();
      case CricketCardComparisonRuleType.greaterFifties:
        return GreaterHalfCenturiesRule();
      case CricketCardComparisonRuleType.greaterWickets:
        return GreaterWicketsRule();
      case CricketCardComparisonRuleType.greaterCatches:
        return GreaterCatchesRule();
      case CricketCardComparisonRuleType.lowerRuns:
        return LowerRunsRule();
      case CricketCardComparisonRuleType.lowerMatches:
        return LowerMatchesRule();
      case CricketCardComparisonRuleType.lowerCenturies:
        return LowerCenturiesRule();
      case CricketCardComparisonRuleType.lowerFifties:
        return LowerHalfCenturiesRule();
      case CricketCardComparisonRuleType.lowerWickets:
        return LowerWicketsRule();
      case CricketCardComparisonRuleType.lowerCatches:
        return LowerCatchesRule();
    }
  }

  /// Compare two cards and return the result
  ComparisionResult compare(
      {required CricketCardInterface card1,
      required CricketCardInterface card2});
}

//MARK: Greater Rules
class GreaterRunsRule extends GreaterComparisonRule
    implements CricketCardComparisonRule {
  @override
  ComparisionResult compare(
      {required CricketCardInterface card1,
      required CricketCardInterface card2}) {
    return compareValues(attribute1: card1.runs, attribute2: card2.runs);
  }
}

class GreaterWicketsRule extends GreaterComparisonRule
    implements CricketCardComparisonRule {
  GreaterWicketsRule();

  @override
  ComparisionResult compare(
      {required CricketCardInterface card1,
      required CricketCardInterface card2}) {
    return compareValues(attribute1: card1.wickets, attribute2: card2.wickets);
  }
}

class GreaterMatchesRule extends GreaterComparisonRule
    implements CricketCardComparisonRule {
  GreaterMatchesRule();

  @override
  ComparisionResult compare(
      {required CricketCardInterface card1,
      required CricketCardInterface card2}) {
    return compareValues(attribute1: card1.matches, attribute2: card2.matches);
  }
}

class GreaterCenturiesRule extends GreaterComparisonRule
    implements CricketCardComparisonRule {
  GreaterCenturiesRule();

  @override
  ComparisionResult compare(
      {required CricketCardInterface card1,
      required CricketCardInterface card2}) {
    return compareValues(
        attribute1: card1.centuries, attribute2: card2.centuries);
  }
}

class GreaterHalfCenturiesRule extends GreaterComparisonRule
    implements CricketCardComparisonRule {
  @override
  ComparisionResult compare(
      {required CricketCardInterface card1,
      required CricketCardInterface card2}) {
    return compareValues(
        attribute1: card1.halfCenturies, attribute2: card2.halfCenturies);
  }
}

class GreaterCatchesRule extends GreaterComparisonRule
    implements CricketCardComparisonRule {
  GreaterCatchesRule();

  @override
  ComparisionResult compare(
      {required CricketCardInterface card1,
      required CricketCardInterface card2}) {
    return compareValues(attribute1: card1.catches, attribute2: card2.catches);
  }
}

//MARK: Lower Rules
class LowerRunsRule extends LowerComparisonRule
    implements CricketCardComparisonRule {
  @override
  ComparisionResult compare(
      {required CricketCardInterface card1,
      required CricketCardInterface card2}) {
    return compareValues(attribute1: card1.runs, attribute2: card2.runs);
  }
}

class LowerMatchesRule extends LowerComparisonRule
    implements CricketCardComparisonRule {
  @override
  ComparisionResult compare(
      {required CricketCardInterface card1,
      required CricketCardInterface card2}) {
    return compareValues(attribute1: card1.matches, attribute2: card2.matches);
  }
}

class LowerCenturiesRule extends LowerComparisonRule
    implements CricketCardComparisonRule {
  @override
  ComparisionResult compare(
      {required CricketCardInterface card1,
      required CricketCardInterface card2}) {
    return compareValues(
        attribute1: card1.centuries, attribute2: card2.centuries);
  }
}

class LowerHalfCenturiesRule extends LowerComparisonRule
    implements CricketCardComparisonRule {
  @override
  ComparisionResult compare(
      {required CricketCardInterface card1,
      required CricketCardInterface card2}) {
    return compareValues(
        attribute1: card1.halfCenturies, attribute2: card2.halfCenturies);
  }
}

class LowerWicketsRule extends LowerComparisonRule
    implements CricketCardComparisonRule {
  @override
  ComparisionResult compare(
      {required CricketCardInterface card1,
      required CricketCardInterface card2}) {
    return compareValues(attribute1: card1.wickets, attribute2: card2.wickets);
  }
}

class LowerCatchesRule extends LowerComparisonRule
    implements CricketCardComparisonRule {
  @override
  ComparisionResult compare(
      {required CricketCardInterface card1,
      required CricketCardInterface card2}) {
    return compareValues(attribute1: card1.catches, attribute2: card2.catches);
  }
}
