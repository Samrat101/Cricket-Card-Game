import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/game_modes/standard_mode.dart';
import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
import 'package:cricket_card_game/interfaces/result.dart';

/// Player's final card deals double damage if they win the comparison
class WorldCupMode extends StandardMode implements GameLevelMode {
  @override
  double get activePlayerDamage => GameModeType.standard.winDamage;
  @override
  double get opponentDamage => GameModeType.standard.lossDamage;
  final bool _isLastCardForActivePlayer;
  final CricketCardInterface _roundLeaderCard;
  WorldCupMode(
      {required super.cards,
      required super.roundLeaderCard,
      required super.cardAttributeType,
      required bool isLastCardForActivePlayer})
      : _isLastCardForActivePlayer = isLastCardForActivePlayer,
        _roundLeaderCard = roundLeaderCard;
  @override
  RoundLevelResult get result {
    final comparisionResult = super.result;
    if (!_isLastCardForActivePlayer) {
      return comparisionResult;
    }
    if (comparisionResult.leaderResult == ComparisonOutcome.win) {
      return RoundLevelResult(
          activePlayerDamage: activePlayerDamage,
          opponentPlayerDamage: opponentDamage * 2,
          leaderResult: ComparisonOutcome.win,
          tiedCards: [],
          winnerCard: _roundLeaderCard);
    }
    return comparisionResult;
  }
}
