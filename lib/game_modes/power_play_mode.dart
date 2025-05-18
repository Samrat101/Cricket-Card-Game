import 'package:cricket_card_game/comparator.dart';
import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/interfaces/card/card_attribute.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
import 'package:cricket_card_game/interfaces/result.dart';

class PowerPlayMode implements Mode {
  @override
  double get opponentDamage => GameModeType.powerPlay.winDamage;
  @override
  double get activePlayerDamage => GameModeType.powerPlay.lossDamage;
  final CardAttribute player1A1;
  final CardAttribute player1A2;
  final CardAttribute player2A1;
  final CardAttribute player2A2;
  PowerPlayMode(this.player1A1, this.player1A2, this.player2A1, this.player2A2);
  @override
  Result get result {
    final firstAttributeResult = player1A1.compare(player2A1);
    if (firstAttributeResult == ComparisonOutcome.win) {
      return Result(
          activePlayerDamage: 0,
          opponentPlayerDamage: opponentDamage,
          result: firstAttributeResult);
    }
    final secondAttributeResult = player1A2.compare(player2A2);
    if (secondAttributeResult == ComparisonOutcome.win) {
      return Result(
          activePlayerDamage: activePlayerDamage,
          opponentPlayerDamage: opponentDamage,
          result: secondAttributeResult);
    }
    return Result(
        activePlayerDamage: 0,
        opponentPlayerDamage: 0,
        result: ComparisonOutcome.tie);
  }
}
