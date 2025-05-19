import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/game_modes/standard_mode.dart';
import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
import 'package:cricket_card_game/interfaces/result.dart';

/// Player can compare two attributes instead of one and wins if they have
///  the higher value in either attribute, but damage dealt is reduced to 10%
class PowerPlayMode implements GameLevelMode {
  @override
  double get opponentDamage => GameModeType.powerPlay.winDamage;
  @override
  double get activePlayerDamage => GameModeType.powerPlay.lossDamage;
  final List<CricketCardInterface> _cards;
  final CardAttributeType _cardAttributeType;
  final CardAttributeType _cardAttributeType2;
  final CricketCardInterface _roundLeaderCard;
  PowerPlayMode({
    required List<CricketCardInterface> cards,
    required CardAttributeType cardAttributeType,
    required CardAttributeType cardAttributeType2,
    required CricketCardInterface roundLeaderCard,
  })  : _cards = cards,
        _roundLeaderCard = roundLeaderCard,
        _cardAttributeType = cardAttributeType,
        _cardAttributeType2 = cardAttributeType2;

  @override
  Result get result {
    final firstResult = _getAttributeResult(_cardAttributeType);
    var firstComparisionTied = false;
    switch (firstResult.leaderResult) {
      case ComparisonOutcome.win:
        return Result(
          activePlayerDamage: activePlayerDamage,
          opponentPlayerDamage: opponentDamage,
          leaderResult: ComparisonOutcome.win,
          tiedCards: [],
          winnerCard: firstResult.winnerCard,
        );
      case ComparisonOutcome.tie:
        firstComparisionTied = true;
      default:
        break;
    }
    final secondResult = _getAttributeResult(_cardAttributeType2);
    switch (secondResult.leaderResult) {
      case ComparisonOutcome.win:
        return Result(
          activePlayerDamage: activePlayerDamage,
          opponentPlayerDamage: opponentDamage,
          leaderResult: ComparisonOutcome.win,
          tiedCards: [],
          winnerCard: secondResult.winnerCard,
        );
      case ComparisonOutcome.tie:
        return Result(
          activePlayerDamage: activePlayerDamage,
          opponentPlayerDamage: opponentDamage,
          leaderResult: ComparisonOutcome.tie,
          tiedCards: secondResult.tiedCards,
          winnerCard: null,
        );
      case ComparisonOutcome.loss:
        if (firstComparisionTied) {
          return Result(
            activePlayerDamage: activePlayerDamage,
            opponentPlayerDamage: opponentDamage,
            leaderResult: ComparisonOutcome.tie,
            tiedCards: firstResult.tiedCards,
            winnerCard: null,
          );
        }
        break;
      default:
        break;
    }

    return Result(
      activePlayerDamage: activePlayerDamage,
      opponentPlayerDamage: opponentDamage,
      leaderResult: ComparisonOutcome.loss,
      tiedCards: firstResult.tiedCards,
      winnerCard: firstResult.tiedCards.isEmpty ? firstResult.winnerCard : null,
    );
  }

  Result _getAttributeResult(CardAttributeType attributeType) {
    return StandardMode(
      cards: _cards,
      cardAttributeType: attributeType,
      roundLeaderCard: _roundLeaderCard,
    ).result;
  }
}
