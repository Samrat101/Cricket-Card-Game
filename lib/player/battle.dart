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

//TODO: make health configurable via battle.
class Game {
  final List<PlayerInterface> players;
  final List<CricketCardInterface> cards;
  int _currentTurnPlayerIndex = 0;
  CardAttributeType? selectedAttribute;
  Game(this.players, this.cards);

  PlayerInterface get currentTurnPlayer => players[_currentTurnPlayerIndex];
  PlayerInterface get _nextTurnPlayer =>
      players[_nextIndexInRound(afterIndex: _currentTurnPlayerIndex)];
  (PlayerInterface player, int index)? currentRoundLeader;
  (PlayerInterface player, int index) get _nextRoundLeader {
    final nextRoundLeaderIndex =
        _nextIndexInRound(afterIndex: currentRoundLeader!.$2);
    return (players[nextRoundLeaderIndex], nextRoundLeaderIndex);
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
    selectedAttribute = null;
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
    currentTurnPlayer.currentCard = card;
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
    if (selectedAttribute != null) {
      _moveTurnToNextPlayer();
    }
  }

  bool canChangeSpecialMode({required PlayerInterface player}) {
    return player.name == currentRoundLeader?.$1.name &&
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

  void _compareCards() {
    if (currentRoundLeader case final roundLeader?) {
      if (selectedAttribute case final attributeToCompare?) {
        var activeMode = roundLeader.$1.isSpecialModeActive
            ? roundLeader.$1.specialMode
            : null;
        activeMode ??= GameModeType.standard;
        final Mode modeObject =
            _createModeObject(activeMode, roundLeader.$1, attributeToCompare);
        final result = modeObject.result;
        _calculateAndupdatePlayerHealth(activeMode, result, roundLeader.$1);
        _updateSpecialModeState(activeMode);
      }
    }
  }

  Mode _createModeObject(GameModeType gamMode, PlayerInterface roundLeader,
      CardAttributeType attributeToCompare) {
    switch (gamMode) {
      case GameModeType.standard:
        return StandardMode(
            players: players,
            roundLeader: roundLeader,
            cardAttributeType: attributeToCompare);
      case GameModeType.powerPlay:
        return PowerPlayMode(
            players: players,
            roundLeader: roundLeader,
            cardAttributeType: attributeToCompare,
            cardAttributeType2: attributeToCompare);
      case GameModeType.superr:
        return SuperMode(
            players: players,
            roundLeader: roundLeader,
            gameCards: roundLeader.cards);
      case GameModeType.freeHit:
        return FreeHitMode(
            players: players,
            roundLeader: roundLeader,
            cardAttributeType: attributeToCompare);
      case GameModeType.worldCup:
        final isLastCardForActivePlayer =
            roundLeader.cards.where((e) => !e.isDiscarded).length == 1;
        return WorldCupMode(
            players: players,
            roundLeader: roundLeader,
            cardAttributeType: attributeToCompare,
            isLastCardForActivePlayer: isLastCardForActivePlayer);
    }
  }

  void _calculateAndupdatePlayerHealth(
      GameModeType gamMode, Result result, PlayerInterface roundLeader) {
    switch (gamMode) {
      case GameModeType.standard:
        if (result.tiedPlayers.isNotEmpty) {
          final nonTiePlayers =
              players.where((e) => !result.tiedPlayers.contains(e));
          _updatePlayersHealthForLeaderDamage(nonTiePlayers, result);
        } else {
          _updatePlayersHealthForLeaderDamage(players, result);
        }
      case GameModeType.powerPlay:
      case GameModeType.superr:
        if (result.leaderResult == ComparisonOutcome.win) {
          _updatePlayersHealthForLeaderDamage(players, result);
        } else if (result.tiedPlayers.isNotEmpty) {
          final nonTiedPlayers =
              players.where((e) => !result.tiedPlayers.contains(e));
          _updatePlayersHealthForNonLeaderDamage(nonTiedPlayers, result);
        } else {
          _updatePlayersHealthForNonLeaderDamage(players, result);
        }
      case GameModeType.freeHit:
        if (result.leaderResult == ComparisonOutcome.win) {
          _updatePlayersHealthForLeaderDamage(players, result);
        } else {
          if (result.tiedPlayers.isNotEmpty) {
            final didLeaderGotTied = result.tiedPlayers.contains(roundLeader);
            if (didLeaderGotTied) {
              final nonTiedPlayers =
                  players.where((e) => !result.tiedPlayers.contains(e));
              _updatePlayersHealthForNonLeaderDamage(nonTiedPlayers, result);
            } else {
              _updateHealthForNonLeaderPlayers(roundLeader, result);
            }
          } else {
            _updateHealthForNonLeaderPlayers(roundLeader, result);
          }
        }
      case GameModeType.worldCup:
        if (result.leaderResult == ComparisonOutcome.win) {
          _updatePlayersHealthForLeaderDamage(players, result);
        } else if (result.tiedPlayers.isNotEmpty) {
          final nonTiePlayers =
              players.where((e) => !result.tiedPlayers.contains(e));
          _updatePlayersHealthForNonLeaderDamage(nonTiePlayers, result);
        } else {
          _updatePlayersHealthForNonLeaderDamage(players, result);
        }
        final isLastCardForActivePlayer =
            roundLeader.cards.where((e) => !e.isDiscarded).length == 1;
        if (isLastCardForActivePlayer) {
          currentTurnPlayer.isSpecialModeActive = false;
          currentTurnPlayer.didUseSpecialMode = true;
        }
    }
  }

  void _updateHealthForNonLeaderPlayers(
      PlayerInterface roundLeader, Result result) {
    roundLeader.updateHealth(-result.activePlayerDamage);
    final playersOtherThanLeader = players.where((e) => e.id != roundLeader.id);
    _updatePlayersHealthForNonLeaderDamage(playersOtherThanLeader, result);
  }

  /// updates all players who are not winner
  /// with -{Result.opponentPlayerDamage}
  void _updatePlayersHealthForLeaderDamage(
      Iterable<PlayerInterface> players, Result result) {
    for (var player in players) {
      if (player.id != result.winnerPlayer?.id) {
        player.updateHealth(-result.opponentPlayerDamage);
      }
    }
  }

  /// updates all players who are not winner
  /// with -{Result.opponentPlayerDamage}
  void _updatePlayersHealthForNonLeaderDamage(
      Iterable<PlayerInterface> players, Result result) {
    for (var player in players) {
      if (player.id != result.winnerPlayer?.id) {
        player.updateHealth(-GameModeType.standard.lossDamage);
      }
    }
  }

  void _updateSpecialModeState(GameModeType gamMode) {
    if (gamMode == GameModeType.worldCup) return;

    if (currentTurnPlayer.isSpecialModeActive) {
      currentTurnPlayer.isSpecialModeActive = false;
      currentTurnPlayer.didUseSpecialMode = true;
    }
  }

  int _nextIndexInRound({required int afterIndex}) {
    return (afterIndex + 1) % players.length;
  }

  void attributeSelected(String attribute) {
    final attributeType = CardAttributeType.from(attribute);
    if (attributeType != null) {
      selectedAttribute = attributeType;
    }
    if (currentRoundLeader == null) {
      return;
    }
    _moveTurnToNextPlayer();
  }
}


/*
Questions:
1. Free hit mode:
  - let say there are 4 players
  - according to rule, if win deals 12.5 damage to opponents and if
    lose 15 damage to self
  - If player B wins, then 
2. Standard mode:
  - let say there are 4 players
  - if roundLeader loses, and there is a tie between B and C.
  what will be the damage to A , D.
3. Powerplay mode:
  - let say there are 4 players
  - A selected 2 attributes, and got lost in one and a tied with B in another one.
  - does he deal damage? . and what will be the damage to 
  C and D.
4. Super mode:
  - If the player has both the highest runs card and highest
  wickets card in their hand, they deal 25 damage per win
  - In A,B,C,D A is the leader. and A didn't have highest runs,wickets
  But C has it. What will be the damage for A,B,D. 10 or 25?
  - In A,B,C,D A is the leader. and A didn't have highest runs,wickets
  But C has highest runs and D has highest wickets. 
  What will be the damage for A,B,CD. 10 or 25?
5. World cup mode:
  - let say there are  players A,B,C,D
  - A did not win the round. D did. damage for A,B,C, will be 10 ?
  
*/

