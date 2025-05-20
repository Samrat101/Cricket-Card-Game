import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';
import 'package:cricket_card_game/player/player_interface.dart';

class RoundLevelResult {
  final double activePlayerDamage;
  final double opponentPlayerDamage;
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

class BattleLevelModeResult {
  final double activePlayerDamage;
  final double opponentPlayerDamage;
  final ComparisonOutcome leaderResult;
  final PlayerInterface? winnerPlayer;

  BattleLevelModeResult({
    required this.activePlayerDamage,
    required this.opponentPlayerDamage,
    required this.leaderResult,
    required this.winnerPlayer,
  });
}
