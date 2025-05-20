import 'package:cricket_card_game/interfaces/result.dart';

abstract class Mode {
  /// this is the damage dealt to opponents, if the active
  /// player wins the comparison.
  double get opponentDamage;

  /// this is the damage dealt to the active player, if the
  /// opponent wins the comparison.
  double get activePlayerDamage;
}

abstract class RoundLevelMode implements Mode {
  @override
  double get opponentDamage;
  @override
  double get activePlayerDamage;

  RoundLevelResult get result;
}

abstract class DeckLevelMode implements Mode {
  @override
  double get opponentDamage;

  @override
  double get activePlayerDamage;

  DeckLevelResult get result;
}
