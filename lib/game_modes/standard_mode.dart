import 'package:cricket_card_game/comparator.dart';
import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/interfaces/card_attribute.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
import 'package:cricket_card_game/interfaces/result.dart';

class StandardMode implements Mode {
  final int damage = 10;
  final CardAttribute player1CardAttribute;
  final CardAttribute player2CardAttribute;
  StandardMode(this.player1CardAttribute, this.player2CardAttribute);
  @override
  Result get result {
    final outCome = player1CardAttribute.compare(player2CardAttribute);
    switch (outCome) {
      case ComparisonOutcome.win:
        return Result(
            activePlayerDamage: 0,
            opponentPlayerDamage: damage,
            result: outCome);
      case ComparisonOutcome.loss:
        return Result(
            activePlayerDamage: damage,
            opponentPlayerDamage: 0,
            result: outCome);
      case ComparisonOutcome.tie:
        return Result(
            activePlayerDamage: 0, opponentPlayerDamage: 0, result: outCome);
    }
  }
}
