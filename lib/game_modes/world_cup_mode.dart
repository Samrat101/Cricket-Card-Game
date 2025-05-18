import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/game_modes/standard_mode.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
import 'package:cricket_card_game/interfaces/result.dart';

/// Player's final card deals double damage if they win the comparison
class WorldCupMode extends StandardMode implements Mode {
  @override
  double get activePlayerDamage => GameModeType.standard.winDamage;
  @override
  double get opponentDamage => GameModeType.standard.lossDamage;
  bool isLastCardForActivePlayer;
  WorldCupMode(
      {required super.players,
      required super.roundLeader,
      required super.cardAttributeType,
      required this.isLastCardForActivePlayer});
  @override
  Result get result {
    final comparisionResult = super.result;
    if (!isLastCardForActivePlayer) {
      return comparisionResult;
    }
    if (comparisionResult.leaderResult == ComparisonOutcome.win) {
      return Result(
          activePlayerDamage: activePlayerDamage,
          opponentPlayerDamage: opponentDamage * 2,
          leaderResult: ComparisonOutcome.win,
          tiedPlayers: [],
          winnerPlayer: roundLeader);
    }
    return comparisionResult;
  }
}
