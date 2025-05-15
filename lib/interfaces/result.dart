import 'package:cricket_card_game/enums.dart';

class Result {
  double activePlayerDamage;
  double opponentPlayerDamage;
  ComparisonOutcome result;
  Result({
    required this.activePlayerDamage,
    required this.opponentPlayerDamage,
    required this.result,
  });
}
