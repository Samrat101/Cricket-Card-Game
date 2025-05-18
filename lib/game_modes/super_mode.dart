import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
import 'package:cricket_card_game/interfaces/result.dart';
import 'package:cricket_card_game/player/player_interface.dart';

/// If the player has both the highest runs card and highest
/// wickets card in their hand, they deal 25 damage per win
class SuperMode implements Mode {
  @override
  double get opponentDamage => GameModeType.superr.winDamage;
  @override
  double get activePlayerDamage => GameModeType.superr.lossDamage;
  List<PlayerInterface> players;
  PlayerInterface roundLeader;
  List<CricketCardInterface> gameCards;
  SuperMode(
      {required this.players,
      required this.roundLeader,
      required this.gameCards});

  // Helper method to find the card with highest runs in a list
  CricketCardInterface _findHighestRunsCard(List<CricketCardInterface> cards) {
    if (cards.isEmpty) {
      throw ArgumentError('Cards list cannot be empty');
    }

    return cards.reduce((highest, current) {
      final currentRuns = current.runs.value as num;
      final highestRuns = highest.runs.value as num;
      return currentRuns > highestRuns ? current : highest;
    });
  }

  // Helper method to find the card with highest runs in a list
  CricketCardInterface _findHighestWicketsCard(
      List<CricketCardInterface> cards) {
    if (cards.isEmpty) {
      throw ArgumentError('Cards list cannot be empty');
    }

    return cards.reduce((highest, current) {
      final currentRuns = current.runs.value as num;
      final highestRuns = highest.runs.value as num;
      return currentRuns > highestRuns ? current : highest;
    });
  }

  @override
  Result get result {
    final highestRunsCard = _findHighestRunsCard(gameCards);
    final highestWicketsCard = _findHighestWicketsCard(gameCards);
    final playerWithHighestRuns = players.firstWhere((player) {
      return player.cards.contains(highestRunsCard);
    });
    final playerWithHighestWickets = players.firstWhere((player) {
      return player.cards.contains(highestWicketsCard);
    });
    if (playerWithHighestRuns == roundLeader &&
        playerWithHighestWickets == roundLeader) {
      return Result(
          activePlayerDamage: activePlayerDamage,
          opponentPlayerDamage: opponentDamage,
          leaderResult: ComparisonOutcome.win,
          tiedPlayers: [],
          winnerPlayer: roundLeader);
    } else {
      return Result(
          activePlayerDamage: activePlayerDamage,
          opponentPlayerDamage: opponentDamage,
          leaderResult: ComparisonOutcome.loss,
          tiedPlayers: [],
          winnerPlayer: playerWithHighestRuns);
    }
  }
}
