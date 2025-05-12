enum ComparisionResult { win, lose, tie }

enum CricketCardComparisonRuleType {
  greaterRuns('greaterRuns'),
  greaterMatches('greaterMatches'),
  greaterCenturies('greaterCenturies'),
  greaterFifties('greaterFifties'),
  greaterWickets('greaterWickets'),
  greaterCatches('greaterCatches'),
  lowerRuns('lowerRuns'),
  lowerMatches('lowerMatches'),
  lowerCenturies('lowerCenturies'),
  lowerFifties('lowerFifties'),
  lowerWickets('lowerWickets'),
  lowerCatches('lowerCatches');

  const CricketCardComparisonRuleType(this.rawValue);
  final String rawValue;

  /// This method is used to convert the raw value to the enum value
  /// If the raw value is not found, it will return the default value
  /// which is `greaterRuns`
  static CricketCardComparisonRuleType fromRawValue(String rawValue) {
    return CricketCardComparisonRuleType.values.firstWhere(
        (e) => e.rawValue == rawValue,
        orElse: () => CricketCardComparisonRuleType.greaterRuns);
  }
}
