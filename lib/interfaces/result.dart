import 'package:cricket_card_game/enums.dart';

class Result {
  int activePlayerDamage;
  int opponentPlayerDamage;
  ComparisonOutcome result;
  Result({
    required this.activePlayerDamage,
    required this.opponentPlayerDamage,
    required this.result,
  });
}
