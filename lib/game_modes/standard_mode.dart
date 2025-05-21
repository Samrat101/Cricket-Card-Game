import 'package:cricket_card_game/comparator.dart';
import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
import 'package:cricket_card_game/interfaces/result.dart';

class StandardMode implements RoundLevelMode {
  @override
  double get opponentDamage => GameModeType.standard.winDamage;
  @override
  double get activePlayerDamage => GameModeType.standard.lossDamage;
  final List<CricketCardInterface> _cards;
  final CricketCardInterface _roundLeaderCard;
  final CardAttributeType _cardAttributeType;
  StandardMode(
      {required List<CricketCardInterface> cards,
      required CricketCardInterface roundLeaderCard,
      required CardAttributeType cardAttributeType})
      : _roundLeaderCard = roundLeaderCard,
        _cards = cards,
        _cardAttributeType = cardAttributeType;

  @override
  RoundLevelResult get result {
    final winnerCard = _determineWinnerCard(_cards);
    final tiedCards = _handleTies(_cards, winnerCard);
    return RoundLevelResult(
      activePlayerDamage: activePlayerDamage,
      opponentPlayerDamage: opponentDamage,
      leaderResult: _getLeaderResult(tiedCards, _roundLeaderCard, winnerCard),
      tiedCards: tiedCards,
      winnerCard: tiedCards.isEmpty ? winnerCard : null,
    );
  }

  /// Compares two cards based on the current attribute type
  ComparisonOutcome _compareCards(
      CricketCardInterface card1, CricketCardInterface card2) {
    final attribute1 = card1.getAttribute(withValue: _cardAttributeType.value);
    final attribute2 = card2.getAttribute(withValue: _cardAttributeType.value);
    return attribute1.compare(attribute2);
  }

  /// Determines the winner card from a list of cards
  CricketCardInterface _determineWinnerCard(List<CricketCardInterface> cards) {
    return cards.reduce((currentCard, nextCard) {
      final result = _compareCards(currentCard, nextCard);
      switch (result) {
        case ComparisonOutcome.win:
          return currentCard;
        case ComparisonOutcome.loss:
          return nextCard;
        case ComparisonOutcome.tie:
          return currentCard;
      }
    });
  }

  /// Handles tie cases by filtering cards with matching values
  List<CricketCardInterface> _handleTies(
      List<CricketCardInterface> cards, CricketCardInterface winnerCard) {
    if (cards.isEmpty) return [];

    final winnerValue =
        winnerCard.getAttribute(withValue: _cardAttributeType.value).value;
    return cards.where((card) {
      return card != winnerCard &&
          card.getAttribute(withValue: _cardAttributeType.value).value ==
              winnerValue;
    }).toList();
  }

  /// Determines the comparison outcome for the round leader
  ComparisonOutcome _getLeaderResult(List<CricketCardInterface> tiedCards,
      CricketCardInterface roundLeaderCard, CricketCardInterface winnerCard) {
    if (tiedCards.isNotEmpty) {
      return tiedCards.map((e) => e.id).contains(roundLeaderCard.id)
          ? ComparisonOutcome.tie
          : ComparisonOutcome.loss;
    }
    return roundLeaderCard == winnerCard
        ? ComparisonOutcome.win
        : ComparisonOutcome.loss;
  }
}
