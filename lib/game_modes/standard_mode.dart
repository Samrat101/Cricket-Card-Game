import 'package:cricket_card_game/comparator.dart';
import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/interfaces/card/card_attribute.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
import 'package:cricket_card_game/interfaces/result.dart';

class StandardMode implements Mode {
  @override
  double get opponentDamage => GameModeType.standard.winDamage;
  @override
  double get activePlayerDamage => GameModeType.standard.lossDamage;
  final CardAttribute player1CardAttribute;
  final CardAttribute player2CardAttribute;
  StandardMode(
      {required this.player1CardAttribute, required this.player2CardAttribute});
  @override
  Result get result {
    final outCome = player1CardAttribute.compare(player2CardAttribute);
    switch (outCome) {
      case ComparisonOutcome.win:
        return Result(
            activePlayerDamage: 0,
            opponentPlayerDamage: opponentDamage,
            result: outCome);
      case ComparisonOutcome.loss:
        return Result(
            activePlayerDamage: activePlayerDamage,
            opponentPlayerDamage: 0,
            result: outCome);
      case ComparisonOutcome.tie:
        return Result(
            activePlayerDamage: 0, opponentPlayerDamage: 0, result: outCome);
    }
  }
}
