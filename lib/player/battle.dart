// ignore_for_file: unnecessary_getters_setters

import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/game_modes/free_hit_mode.dart';
import 'package:cricket_card_game/game_modes/power_play_mode.dart';
import 'package:cricket_card_game/game_modes/standard_mode.dart';
import 'package:cricket_card_game/game_modes/super_mode.dart';
import 'package:cricket_card_game/game_modes/world_cup_mode.dart';
import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
import 'package:cricket_card_game/interfaces/result.dart';
import 'package:cricket_card_game/player/player_interface.dart';

class Game {
  final List<PlayerInterface> players;
  final List<CricketCardInterface> cards;
  final double _initialHealthForPlayers = 100;
  (PlayerInterface player, int index)? _currentRoundLeader;
  List<CardAttributeType>? _selectedAttribute = [];

  List<CardAttributeType>? get selectedAttribute => _selectedAttribute;

  int _currentTurnPlayerIndex = 0;

  Game(this.players, this.cards) {
    for (var player in players) {
      player.maxHealth = _initialHealthForPlayers;
      player.updateHealth(_initialHealthForPlayers);
    }
  }

  (PlayerInterface player, int index)? get currentRoundLeader =>
      _currentRoundLeader;
  PlayerInterface get currentTurnPlayer => players[_currentTurnPlayerIndex];
  PlayerInterface get _nextTurnPlayer =>
      players[_nextIndexInRound(afterIndex: _currentTurnPlayerIndex)];
  (PlayerInterface player, int index) get _nextRoundLeader {
    final nextRoundLeaderIndex =
        _nextIndexInRound(afterIndex: currentRoundLeader!.$2);
    return (players[nextRoundLeaderIndex], nextRoundLeaderIndex);
  }

  set currentRoundLeader((PlayerInterface player, int index)? value) {
    _currentRoundLeader = value;
  }

  void start() {
    players[_currentTurnPlayerIndex].isTurnActive = true;
    players[_currentTurnPlayerIndex].isTurnActive = true;
    currentRoundLeader =
        (players[_currentTurnPlayerIndex], _currentTurnPlayerIndex);
    for (var element in players[_currentTurnPlayerIndex].cards) {
      element.canSelect = true;
    }
  }

  void _moveToNextRound() {
    _selectedAttribute = [];
    for (var player in players) {
      for (var element in player.cards) {
        if (element.isSelected) {
          element.updateCardSelectedStatus(false);
          element.isDiscarded = true;
        }
        element.canSelect = false;
      }
    }

    for (var element in _nextRoundLeader.$1.cards) {
      element.canSelect = true;
    }

    currentTurnPlayer.isTurnActive = false;
    _currentTurnPlayerIndex = _nextRoundLeader.$2;
    currentTurnPlayer.isTurnActive = true;
    currentRoundLeader =
        (players[_currentTurnPlayerIndex], _currentTurnPlayerIndex);
  }

  void _moveTurnToNextPlayer() {
    for (var element in _nextTurnPlayer.cards) {
      element.canSelect = true;
    }
    for (var element in currentTurnPlayer.cards) {
      element.canSelect = false;
    }
    currentTurnPlayer.isTurnActive = false;
    _currentTurnPlayerIndex =
        _nextIndexInRound(afterIndex: _currentTurnPlayerIndex);
    currentTurnPlayer.isTurnActive = true;
  }

  void _resetCurrentCardsForPlayers() {
    for (var player in players) {
      player.currentCard = null;
    }
  }

  void _updateSelectedCard(CricketCardInterface card) {
    currentTurnPlayer.currentCard = card.isSelected ? card : null;
  }

  List<PlayerInterface>? isGameOver() {
    List<PlayerInterface> winners = [];
    for (var player in players) {
      if (player.health <= 0) {
        print('${player.name} is out of the game');
        players.remove(player);
      }
    }
    if (currentRoundLeader?.$1.cards.cast<CricketCardInterface?>().firstWhere(
              (element) => element?.isDiscarded == false,
              orElse: () => null,
            ) ==
        null) {
      PlayerInterface winnerPlayer = players.first;
      for (var player in players) {
        if (player.health > winnerPlayer.health) {
          winners = [];
          winners.add(player);
        } else if (player.health == winnerPlayer.health) {
          winners.add(player);
        }
      }
      return winners;
    }
    if (players.length == 1) {
      print('${players.first.name} is the winner');
      winners.add(players.first);
    }
    return winners;
  }

  bool askForSecondAttribute() {
    if (currentRoundLeader?.$1.isSpecialModeActive == true) {
      if (currentRoundLeader?.$1.specialMode == GameModeType.powerPlay) {
        if (_selectedAttribute?.length == 1) {
          return true;
        }
      }
    }
    return false;
  }

  void cardSelectedCallback(CricketCardInterface card) {
    _updateSelectedCard(card);
    if (_didAllPlayersSelectedCards()) {
      _compareCards();
      _resetCurrentCardsForPlayers();
      _moveToNextRound();
      return;
    }
    for (var element in currentTurnPlayer.cards) {
      if (element != card) {
        element.updateCardSelectedStatus(false);
      }
    }
    if (_selectedAttribute?.isNotEmpty ?? true) {
      _moveTurnToNextPlayer();
    }
  }

  bool canChangeSpecialMode({required PlayerInterface player}) {
    return player.id == currentRoundLeader?.$1.id &&
        !player.didUseSpecialMode &&
        !_isRoundInProgress();
  }

  bool _isRoundInProgress() {
    for (var player in players) {
      if (player.currentCard != null) {
        return true;
      }
    }
    return false;
  }

  bool isRoundLeaderCardSelected() {
    return currentRoundLeader?.$1.currentCard != null;
  }

  bool _didAllPlayersSelectedCards() {
    for (var player in players) {
      if (player.currentCard != null) {
        continue;
      } else {
        return false;
      }
    }
    return true;
  }

  void activateSpecialMode({required PlayerInterface player}) {
    player.toggleSpecialMode();
    if (player == currentRoundLeader?.$1 && player.isSpecialModeActive) {
      final mode = player.specialMode;
      if (mode != null && mode.isDeckLevelMode) {
        _handleDeckLevelMode(mode, player);
        _moveToNextRound();
      }
    }
  }

  void _compareCards() {
    if (currentRoundLeader case final roundLeader?) {
      if (_selectedAttribute case final attributeToCompare?) {
        var activeMode = roundLeader.$1.isSpecialModeActive
            ? roundLeader.$1.specialMode
            : null;
        activeMode ??= GameModeType.standard;
        if (activeMode.isDeckLevelMode) {
          _handleDeckLevelMode(activeMode, roundLeader.$1);
          return;
        }
        final RoundLevelMode modeObject = _createRoundLevelModeObject(
            activeMode, roundLeader.$1, attributeToCompare);
        final result = modeObject.result;
        _calculateAndupdatePlayerHealth(activeMode, result, roundLeader.$1);
        _updateSpecialModeState(activeMode);
      }
    }
  }

  /// super mode is handled separately
  /// because it has different logic
  void _handleDeckLevelMode(
      GameModeType activeMode, PlayerInterface roundLeader) {
    final DeckLevelMode object;
    switch (activeMode) {
      case GameModeType.superr:
        object = SuperMode(players: players, roundLeader: roundLeader);
        break;
      default:
        throw UnimplementedError();
    }
    final result = object.result;
    switch (result.leaderResult) {
      case ComparisonOutcome.win:
        for (var player in players) {
          if (player != roundLeader) {
            player.updateHealth(-result.opponentPlayerDamage);
          }
        }
        break;
      case ComparisonOutcome.loss:
        for (var player in players) {
          if (player != result.winnerPlayer) {
            player.updateHealth(-GameModeType.standard.winDamage);
          }
        }
        break;
      case ComparisonOutcome.tie:
        break;
    }
    _updateSpecialModeState(activeMode);
  }

  List<CricketCardInterface> get _selectedCardsInThisRound {
    final list = <CricketCardInterface>[];
    for (var player in players) {
      list.add(player.currentCard!);
    }
    return list;
  }

  RoundLevelMode _createRoundLevelModeObject(GameModeType gamMode,
      PlayerInterface roundLeader, List<CardAttributeType> attributeToCompare) {
    switch (gamMode) {
      case GameModeType.standard:
        return StandardMode(
            cards: _selectedCardsInThisRound,
            roundLeaderCard: roundLeader.currentCard!,
            cardAttributeType: attributeToCompare.first);
      case GameModeType.powerPlay:
        return PowerPlayMode(
            cards: _selectedCardsInThisRound,
            roundLeaderCard: roundLeader.currentCard!,
            cardAttributeType: attributeToCompare.first,
            cardAttributeType2: attributeToCompare.last);
      case GameModeType.freeHit:
        return FreeHitMode(
            cards: _selectedCardsInThisRound,
            roundLeaderCard: roundLeader.currentCard!,
            cardAttributeType: attributeToCompare.first);
      case GameModeType.worldCup:
        final isLastCardForActivePlayer =
            roundLeader.cards.where((e) => !e.isDiscarded).length == 1;
        return WorldCupMode(
            cards: _selectedCardsInThisRound,
            roundLeaderCard: roundLeader.currentCard!,
            cardAttributeType: attributeToCompare.first,
            isLastCardForActivePlayer: isLastCardForActivePlayer);
      default:
        throw UnimplementedError();
    }
  }

  void _calculateAndupdatePlayerHealth(GameModeType gamMode,
      RoundLevelResult result, PlayerInterface roundLeader) {
    switch (gamMode) {
      case GameModeType.standard:
        _updatePlayersHealth(result);
      case GameModeType.powerPlay:
        _updatePlayersHealth(result);
      case GameModeType.superr:
        _updatePlayersHealth(result);
      case GameModeType.freeHit:
        if (result.leaderResult == ComparisonOutcome.win) {
          _updatePlayersHealthForLeaderDamage(players, result);
        } else {
          if (result.tiedCards.isNotEmpty) {
            final didLeaderGotTied =
                result.tiedCards.contains(roundLeader.currentCard);
            if (didLeaderGotTied) {
              final nonTiedPlayers = players
                  .where((e) => !result.tiedCards.contains(e.currentCard));
              _updatePlayersHealthForNonLeaderDamage(nonTiedPlayers, result);
            } else {
              _updateHealthForNonLeaderPlayers(roundLeader, result);
            }
          } else {
            _updateHealthForNonLeaderPlayers(roundLeader, result);
          }
        }
      case GameModeType.worldCup:
        _updatePlayersHealth(result);
        final isLastCardForActivePlayer =
            roundLeader.cards.where((e) => !e.isDiscarded).length == 1;
        if (isLastCardForActivePlayer) {
          currentTurnPlayer.isSpecialModeActive = false;
          currentTurnPlayer.didUseSpecialMode = true;
        }
    }
  }

  void _updatePlayersHealth(RoundLevelResult result) {
    if (result.leaderResult == ComparisonOutcome.win) {
      _updatePlayersHealthForLeaderDamage(players, result);
    } else if (result.tiedCards.isNotEmpty) {
      final nonTiePlayers =
          players.where((e) => !result.tiedCards.contains(e.currentCard));
      _updatePlayersHealthForNonLeaderDamage(nonTiePlayers, result);
    } else {
      _updatePlayersHealthForNonLeaderDamage(players, result);
    }
  }

  /// since leader got lost in free hit mode, he deals
  /// additional damage compared to other losers.
  void _updateHealthForNonLeaderPlayers(
      PlayerInterface roundLeader, RoundLevelResult result) {
    roundLeader.updateHealth(-result.activePlayerDamage);
    final playersOtherThanLeader = players.where((e) => e != roundLeader);
    _updatePlayersHealthForNonLeaderDamage(playersOtherThanLeader, result);
  }

  /// updates all players who are not winner
  /// with -{Result.opponentPlayerDamage}
  void _updatePlayersHealthForLeaderDamage(
      Iterable<PlayerInterface> players, RoundLevelResult result) {
    for (var player in players) {
      if (player.currentCard?.id != result.winnerCard?.id) {
        player.updateHealth(-result.opponentPlayerDamage);
      }
    }
  }

  /// updates all players who are not winner
  /// with -{Result.opponentPlayerDamage}
  void _updatePlayersHealthForNonLeaderDamage(
      Iterable<PlayerInterface> players, RoundLevelResult result) {
    for (var player in players) {
      if (player.currentCard?.id != result.winnerCard?.id) {
        player.updateHealth(-GameModeType.standard.lossDamage);
      }
    }
  }

  void _updateSpecialModeState(GameModeType gamMode) {
    if (gamMode == GameModeType.worldCup) return;

    if (currentRoundLeader?.$1.isSpecialModeActive == true) {
      currentRoundLeader?.$1.isSpecialModeActive = false;
      currentRoundLeader?.$1.didUseSpecialMode = true;
    }
  }

  int _nextIndexInRound({required int afterIndex}) {
    return (afterIndex + 1) % players.length;
  }

  void attributeSelected(String attribute) {
    final attributeType = CardAttributeType.from(attribute);
    if (attributeType != null) {
      _selectedAttribute?.add(attributeType);
    }
    if (currentRoundLeader == null) {
      return;
    }
    if (askForSecondAttribute()) {
      return;
    }
    _moveTurnToNextPlayer();
  }
}
