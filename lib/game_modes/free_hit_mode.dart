import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/game_modes/standard_mode.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
import 'package:cricket_card_game/interfaces/result.dart';

class FreeHitMode extends StandardMode implements Mode {
  @override
  double get opponentDamage => GameModeType.freeHit.winDamage;
  @override
  double get activePlayerDamage => GameModeType.freeHit.lossDamage;
  FreeHitMode({
    required super.player1CardAttribute,
    required super.player2CardAttribute,
  });

  @override
  Result get result {
    switch (super.result.result) {
      case ComparisonOutcome.win:
        return Result(
            activePlayerDamage: 0,
            opponentPlayerDamage: opponentDamage,
            result: ComparisonOutcome.win);
      case ComparisonOutcome.loss:
        return Result(
            activePlayerDamage: activePlayerDamage,
            opponentPlayerDamage: 0,
            result: ComparisonOutcome.loss);
      case ComparisonOutcome.tie:
        return Result(
            activePlayerDamage: 0,
            opponentPlayerDamage: 0,
            result: ComparisonOutcome.tie);
    }
  }
}
