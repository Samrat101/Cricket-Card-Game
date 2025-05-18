import 'package:cricket_card_game/enums.dart';

class Result {
  final double activePlayerDamage;
  final double opponentPlayerDamage;
  final ComparisonOutcome result;
  Result({
    required this.activePlayerDamage,
    required this.opponentPlayerDamage,
    required this.result,
  });
}
