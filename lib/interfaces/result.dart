import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/player/player_interface.dart';

class Result {
  final double activePlayerDamage;
  final double opponentPlayerDamage;
  final ComparisonOutcome leaderResult;
  final List<PlayerInterface> tiedPlayers;
  final PlayerInterface? winnerPlayer;
  Result({
    required this.activePlayerDamage,
    required this.opponentPlayerDamage,
    required this.leaderResult,
    required this.tiedPlayers,
    this.winnerPlayer,
  });
}
