enum ComparisionWin {
  lower('lower'),
  greater('greater');

  const ComparisionWin(this.value);
  final String value;

  static ComparisionWin from(String rawValue) {
    return ComparisionWin.values.firstWhere(
      (element) => element.value == rawValue,
      orElse: () => ComparisionWin.greater,
    );
  }
}

enum ComparisonOutcome { win, loss, tie }

enum SpecialMode {
  powerPlayMode('Power Play Mode'),
  superMode('Super Mode'),
  freeHitMode('Free Hit Mode');

  final String displayName;

  const SpecialMode(this.displayName);
}

SpecialMode? getSpecialModeFromString(String input) {
  for (var mode in SpecialMode.values) {
    if (mode.displayName.toLowerCase() == input.toLowerCase()) {
      return mode;
    }
  }
  return null; // or throw an error if you prefer
}
