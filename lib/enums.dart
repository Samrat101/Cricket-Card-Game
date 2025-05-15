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

  GameModeType get gameModeType => switch (this) {
        SpecialMode.powerPlayMode => GameModeType.powerPlay,
        SpecialMode.superMode => GameModeType.superr,
        SpecialMode.freeHitMode => GameModeType.freeHit,
      };
}

enum GameModeType {
  standard('standard'),
  powerPlay('powerPlay'),
  superr('super'),
  freeHit('freeHit');

  const GameModeType(this.value);
  final String value;

  double get winDamage => switch (this) {
        GameModeType.powerPlay => 10,
        GameModeType.superr => 25,
        GameModeType.freeHit => 5,
        GameModeType.standard => 10,
      };

  double get lossDamage => switch (this) {
        GameModeType.powerPlay => 5,
        GameModeType.superr => 15,
        GameModeType.freeHit => 0,
        GameModeType.standard => 10,
      };
}

SpecialMode? getSpecialModeFromString(String input) {
  for (var mode in SpecialMode.values) {
    if (mode.displayName.toLowerCase() == input.toLowerCase()) {
      return mode;
    }
  }
  return null; // or throw an error if you prefer
}

enum CardAttributeType {
  name('name'),
  catches('catches'),
  centuries('centuries'),
  halfCenturies('half_centuries'),
  matches('matches'),
  runs('runs'),
  wickets('wickets');

  const CardAttributeType(this.value);
  final String value;

  static CardAttributeType? from(String rawValue) {
    return CardAttributeType.values.cast<CardAttributeType?>().firstWhere(
          (element) => element?.value == rawValue,
          orElse: () => null,
        );
  }
}
