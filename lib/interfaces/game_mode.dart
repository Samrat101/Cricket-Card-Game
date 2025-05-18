import 'package:cricket_card_game/interfaces/result.dart';

abstract class Mode {
  /// this is the damage dealt to opponents, if the active
  /// player wins the comparison.
  double get opponentDamage;

  /// this is the damage dealt to the active player, if the
  /// opponent wins the comparison.
  double get activePlayerDamage;

  Result get result;
}