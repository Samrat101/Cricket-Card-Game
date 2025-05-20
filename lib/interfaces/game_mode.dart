import 'package:cricket_card_game/interfaces/result.dart';

abstract class GameLevelMode {
  /// this is the damage dealt to opponents, if the active
  /// player wins the comparison.
  double get opponentDamage;

  /// this is the damage dealt to the active player, if the
  /// opponent wins the comparison.
  double get activePlayerDamage;

  RoundLevelResult get result;
}

abstract class BattleLevelMode {
  double get opponentDamage;
  double get activePlayerDamage;
  BattleLevelModeResult get result;
}
