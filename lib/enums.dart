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

enum GameModeType {
  standard('standard'),

  /// Player can compare two attributes instead of one and wins if they have
  ///  the higher value in either attribute, but damage dealt is reduced to 10%
  powerPlay('powerPlay'),

  /// If the player has both the highest runs card and highest
  /// wickets card in their hand, they deal 25 damage per win
  superr('super'),

  /// Player deals 12.5% damage when winning but takes 15% damage when losing
  freeHit('freeHit'),

  /// Player's final card deals double damage if they win the comparison
  worldCup('worldCup');

  const GameModeType(this.value);
  final String value;
  final double _standardDamage = 10;

  String get displayName {
    return switch (this) {
      GameModeType.powerPlay => 'Power Play Mode',
      GameModeType.superr => 'Super Mode',
      GameModeType.freeHit => 'Free Hit Mode',
      GameModeType.standard => 'Standard Mode',
      GameModeType.worldCup => 'World Cup Mode',
    };
  }

  static List<GameModeType> get specialModes {
    return [
      GameModeType.powerPlay,
      GameModeType.superr,
      GameModeType.freeHit,
      GameModeType.worldCup,
    ];
  }

  double get winDamage {
    return switch (this) {
      GameModeType.powerPlay => _standardDamage,
      GameModeType.superr => 25,
      GameModeType.freeHit => 12.5,
      GameModeType.standard => _standardDamage,
      GameModeType.worldCup => _standardDamage * 2,
    };
  }

  double get lossDamage {
    return switch (this) {
      GameModeType.powerPlay => _standardDamage,
      GameModeType.superr => _standardDamage,
      GameModeType.freeHit => 15,
      GameModeType.standard => _standardDamage,
      GameModeType.worldCup => _standardDamage,
    };
  }

  bool get isDeckLevelMode {
    return this == GameModeType.superr;
  }
}

GameModeType? getSpecialModeFromString(String input) {
  for (var mode in GameModeType.values) {
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

  String get displayName {
    return switch (this) {
      CardAttributeType.catches => 'Catches',
      CardAttributeType.centuries => 'Centuries',
      CardAttributeType.halfCenturies => 'Half Centuries',
      CardAttributeType.matches => 'Matches',
      CardAttributeType.runs => 'Runs',
      CardAttributeType.wickets => 'Wickets',
      CardAttributeType.name => 'Name',
    };
  }

  static List<CardAttributeType> get disPlayAttributes {
    return [
      CardAttributeType.catches,
      CardAttributeType.centuries,
      CardAttributeType.halfCenturies,
      CardAttributeType.matches,
      CardAttributeType.runs,
      CardAttributeType.wickets,
    ];
  }

  static CardAttributeType? from(String rawValue) {
    return CardAttributeType.values.cast<CardAttributeType?>().firstWhere(
          (element) => element?.value == rawValue,
          orElse: () => null,
        );
  }
}
