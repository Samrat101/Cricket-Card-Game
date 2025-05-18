import 'package:cricket_card_game/comparator.dart';
import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
import 'package:cricket_card_game/interfaces/result.dart';
import 'package:cricket_card_game/player/player_interface.dart';

class StandardMode implements Mode {
  @override
  double get opponentDamage => GameModeType.standard.winDamage;
  @override
  double get activePlayerDamage => GameModeType.standard.lossDamage;
  final List<PlayerInterface> _players;
  final PlayerInterface roundLeader;
  final CardAttributeType _cardAttributeType;
  StandardMode(
      {required List<PlayerInterface> players,
      required this.roundLeader,
      required CardAttributeType cardAttributeType})
      : _players = players,
        _cardAttributeType = cardAttributeType;
  @override
  Result get result {
    var tiedPlayers = <PlayerInterface>[];
    final winnerPlayer = _players.reduce((player, nextPlayer) {
      final playerCard = player.currentCard!;
      final nextPlayerCard = nextPlayer.currentCard!;
      final playerAttribute =
          playerCard.getAttribute(withValue: _cardAttributeType.value);
      final nextPlayerAttribute =
          nextPlayerCard.getAttribute(withValue: _cardAttributeType.value);
      final result = playerAttribute.compare(nextPlayerAttribute);
      switch (result) {
        case ComparisonOutcome.win:
          return player;
        case ComparisonOutcome.loss:
          return nextPlayer;
        case ComparisonOutcome.tie:
          tiedPlayers.addAll([player, nextPlayer]);
          return player;
      }
    });
    if (tiedPlayers.isNotEmpty) {
      tiedPlayers = _players
          .where((e) =>
              e.currentCard!
                  .getAttribute(withValue: _cardAttributeType.value)
                  .value ==
              winnerPlayer.currentCard!
                  .getAttribute(withValue: _cardAttributeType.value)
                  .value)
          .toList();
    }
    return Result(
        activePlayerDamage: activePlayerDamage,
        opponentPlayerDamage: opponentDamage,
        leaderResult: tiedPlayers.isEmpty
            ? winnerPlayer.id == roundLeader.id
                ? ComparisonOutcome.win
                : ComparisonOutcome.loss
            : tiedPlayers.map((e) => e.id).contains(roundLeader.id)
                ? ComparisonOutcome.tie
                : ComparisonOutcome.loss,
        tiedPlayers: tiedPlayers,
        winnerPlayer: winnerPlayer);
  }
}
