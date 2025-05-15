import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/interfaces/cricket_card_interface.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
import 'package:cricket_card_game/interfaces/result.dart';

class SuperMode implements Mode {
  final double winDamage = GameModeType.superr.winDamage;
  final double lossDamage = GameModeType.superr.lossDamage;
  List<CricketCardInterface> player1Cards, player2Cards;
  SuperMode(this.player1Cards, this.player2Cards);

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
    try {
      final player1HighestRuns =
          _findHighestRunsCard(player1Cards).runs.value as num;
      final player2HighestRuns =
          _findHighestRunsCard(player2Cards).runs.value as num;
      final player1HighestWickets =
          _findHighestWicketsCard(player1Cards).wickets.value as num;
      final player2HighestWickets =
          _findHighestWicketsCard(player2Cards).wickets.value as num;
      final didPlayer1Win = player1HighestRuns > player2HighestRuns &&
          player1HighestWickets > player2HighestWickets;
      final didPlayer2Win = player2HighestRuns > player1HighestRuns &&
          player2HighestWickets > player1HighestWickets;
      if (didPlayer1Win) {
        return Result(
          activePlayerDamage: 0,
          opponentPlayerDamage: winDamage,
          result: ComparisonOutcome.win,
        );
      } else if (didPlayer2Win) {
        return Result(
          activePlayerDamage: lossDamage,
          opponentPlayerDamage: 0,
          result: ComparisonOutcome.loss,
        );
      } else {
        // In case of a tie
        return Result(
          activePlayerDamage: 0,
          opponentPlayerDamage: 0,
          result: ComparisonOutcome.tie,
        );
      }
    } catch (e) {
      // Handle the case where either player has no cards
      return Result(
        activePlayerDamage: 0,
        opponentPlayerDamage: 0,
        result: ComparisonOutcome.tie,
      );
    }
  }
}
