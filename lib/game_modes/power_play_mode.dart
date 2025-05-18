import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/game_modes/standard_mode.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
import 'package:cricket_card_game/interfaces/result.dart';
import 'package:cricket_card_game/player/player_interface.dart';

/// Player can compare two attributes instead of one and wins if they have
///  the higher value in either attribute, but damage dealt is reduced to 10%
class PowerPlayMode implements Mode {
  @override
  double get opponentDamage => GameModeType.powerPlay.winDamage;
  @override
  double get activePlayerDamage => GameModeType.powerPlay.lossDamage;
  final List<PlayerInterface> players;
  final CardAttributeType cardAttributeType;
  final CardAttributeType cardAttributeType2;
  final PlayerInterface roundLeader;
  PowerPlayMode({
    required this.players,
    required this.cardAttributeType,
    required this.cardAttributeType2,
    required this.roundLeader,
  });
  @override
  Result get result {
    final firstAttributeResult = StandardMode(
            players: players,
            cardAttributeType: cardAttributeType,
            roundLeader: roundLeader)
        .result;
    final secondAttributeResult = StandardMode(
            players: players,
            cardAttributeType: cardAttributeType2,
            roundLeader: roundLeader)
        .result;
    var tied = false;
    switch (firstAttributeResult.leaderResult) {
      case ComparisonOutcome.win:
        return Result(
            activePlayerDamage: activePlayerDamage,
            opponentPlayerDamage: opponentDamage,
            leaderResult: ComparisonOutcome.win,
            tiedPlayers: firstAttributeResult.tiedPlayers,
            winnerPlayer: roundLeader);
      case ComparisonOutcome.loss:
        break;
      case ComparisonOutcome.tie:
        tied = true;
        break;
    }
    switch (secondAttributeResult.leaderResult) {
      case ComparisonOutcome.win:
        return Result(
            activePlayerDamage: activePlayerDamage,
            opponentPlayerDamage: opponentDamage,
            leaderResult: ComparisonOutcome.win,
            tiedPlayers: secondAttributeResult.tiedPlayers,
            winnerPlayer: roundLeader);
      case ComparisonOutcome.loss:
        break;
      case ComparisonOutcome.tie:
        tied = true;
        break;
    }
    return Result(
        activePlayerDamage: activePlayerDamage,
        opponentPlayerDamage: opponentDamage,
        leaderResult: tied ? ComparisonOutcome.tie : ComparisonOutcome.loss,
        tiedPlayers: secondAttributeResult.tiedPlayers,
        winnerPlayer: tied ? null : firstAttributeResult.winnerPlayer);
  }
}
