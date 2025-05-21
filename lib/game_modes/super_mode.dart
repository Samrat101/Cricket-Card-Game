import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
import 'package:cricket_card_game/interfaces/result.dart';
import 'package:cricket_card_game/player/player_interface.dart';

/// If the player has both the highest runs card and highest
/// wickets card in their hand, they deal 25 damage per win
class SuperMode implements DeckLevelMode {
  @override
  double get opponentDamage => GameModeType.superr.winDamage;
  @override
  double get activePlayerDamage => GameModeType.superr.lossDamage;
  List<PlayerInterface> players;
  PlayerInterface roundLeader;
  SuperMode({required this.players, required this.roundLeader});

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
      final currentWickets = current.wickets.value as num;
      final highestWickets = highest.wickets.value as num;
      return currentWickets > highestWickets ? current : highest;
    });
  }

  @override
  DeckLevelResult get result {
    final allCards = <CricketCardInterface>[];
    for (var player in players) {
      allCards.addAll(player.cards);
    }
    final highestRunsCard = _findHighestRunsCard(allCards);
    final highestWicketsCard = _findHighestWicketsCard(allCards);
    final playerWithHighestRuns = players.firstWhere((player) {
      return player.cards.contains(highestRunsCard);
    });
    final playerWithHighestWickets = players.firstWhere((player) {
      return player.cards.contains(highestWicketsCard);
    });
    if (playerWithHighestRuns == playerWithHighestWickets) {
      if (playerWithHighestRuns == roundLeader) {
        return DeckLevelResult(
            activePlayerDamage: activePlayerDamage,
            opponentPlayerDamage: opponentDamage,
            leaderResult: ComparisonOutcome.win,
            winnerPlayer: playerWithHighestRuns);
      } else {
        return DeckLevelResult(
            activePlayerDamage: activePlayerDamage,
            opponentPlayerDamage: opponentDamage,
            leaderResult: ComparisonOutcome.loss,
            winnerPlayer: playerWithHighestRuns);
      }
    } else {
      // no single player has both highest runs and highest wickets
      // so no damage for any player
      return DeckLevelResult(
          activePlayerDamage: activePlayerDamage,
          opponentPlayerDamage: opponentDamage,
          leaderResult: ComparisonOutcome.tie,
          winnerPlayer: null);
    }
  }
}
