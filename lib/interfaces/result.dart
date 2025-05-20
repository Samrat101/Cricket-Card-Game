import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';
import 'package:cricket_card_game/player/player_interface.dart';

abstract class Result {
  double get activePlayerDamage;
  double get opponentPlayerDamage;
  ComparisonOutcome get leaderResult;
}

class RoundLevelResult implements Result {
  @override
  final double activePlayerDamage;

  @override
  final double opponentPlayerDamage;

  @override
  final ComparisonOutcome leaderResult;

  final List<CricketCardInterface> tiedCards;
  final CricketCardInterface? winnerCard;
  RoundLevelResult({
    required this.activePlayerDamage,
    required this.opponentPlayerDamage,
    required this.leaderResult,
    required this.tiedCards,
    this.winnerCard,
  });
}

class DeckLevelResult implements Result {
  @override
  final double activePlayerDamage;

  @override
  final double opponentPlayerDamage;

  @override
  final ComparisonOutcome leaderResult;

  final PlayerInterface? winnerPlayer;

  DeckLevelResult({
    required this.activePlayerDamage,
    required this.opponentPlayerDamage,
    required this.leaderResult,
    required this.winnerPlayer,
  });
}
