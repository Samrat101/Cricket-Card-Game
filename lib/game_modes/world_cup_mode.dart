import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/game_modes/standard_mode.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
import 'package:cricket_card_game/interfaces/result.dart';

class WorldCupMode extends StandardMode implements Mode {
  @override
  double get activePlayerDamage => GameModeType.standard.winDamage;
  @override
  double get opponentDamage => GameModeType.standard.lossDamage;
  final bool isLastCardForActivePlayer;
  WorldCupMode(
      {required super.player1CardAttribute,
      required super.player2CardAttribute,
      required this.isLastCardForActivePlayer});
  @override
  Result get result {
    switch (super.result.result) {
      case ComparisonOutcome.win:
        return Result(
            activePlayerDamage: 0,
            opponentPlayerDamage: isLastCardForActivePlayer
                ? opponentDamage * 2
                : opponentDamage,
            result: super.result.result);
      case ComparisonOutcome.loss:
        return Result(
            activePlayerDamage: activePlayerDamage,
            opponentPlayerDamage: 0,
            result: super.result.result);
      case ComparisonOutcome.tie:
        return Result(
            activePlayerDamage: 0,
            opponentPlayerDamage: 0,
            result: super.result.result);
    }
  }
}
