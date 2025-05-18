import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/game_modes/free_hit_mode.dart';
import 'package:cricket_card_game/game_modes/power_play_mode.dart';
import 'package:cricket_card_game/game_modes/standard_mode.dart';
import 'package:cricket_card_game/game_modes/super_mode.dart';
import 'package:cricket_card_game/game_modes/world_cup_mode.dart';
import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
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
      players[nextIndexInRound(afterIndex: _currentTurnPlayerIndex)];
  (PlayerInterface player, int index)? currentRoundLeader;
  (PlayerInterface player, int index) get _nextRoundLeader {
    final nextRoundLeaderIndex =
        nextIndexInRound(afterIndex: currentRoundLeader!.$2);
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

  void moveToNextRound() {
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

  void moveTurnToNextPlayer() {
    for (var element in _nextTurnPlayer.cards) {
      element.canSelect = true;
    }
    for (var element in currentTurnPlayer.cards) {
      element.canSelect = false;
    }
    currentTurnPlayer.isTurnActive = false;
    _currentTurnPlayerIndex =
        nextIndexInRound(afterIndex: _currentTurnPlayerIndex);
    currentTurnPlayer.isTurnActive = true;
  }

  void resetCurrentCardsForPlayers() {
    for (var player in players) {
      player.currentCard = null;
    }
  }

  void updateSelectedCard(CricketCardInterface card) {
    currentTurnPlayer.currentCard = card;
  }

  void cardSelectedCallback(CricketCardInterface card) {
    updateSelectedCard(card);
    if (didAllPlayersSelectedCards()) {
      compareCards();
      resetCurrentCardsForPlayers();
      moveToNextRound();
      return;
    }
    for (var element in currentTurnPlayer.cards) {
      if (element != card) {
        element.updateCardSelectedStatus(false);
      }
    }
    if (selectedAttribute != null) {
      moveTurnToNextPlayer();
    }
  }

  bool canChangeSpecialMode({required PlayerInterface player}) {
    return player.name == currentRoundLeader?.$1.name &&
        !player.didUseSpecialMode &&
        !isRoundInProgress();
  }

  bool isRoundInProgress() {
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

  bool didAllPlayersSelectedCards() {
    for (var player in players) {
      if (player.currentCard != null) {
        continue;
      } else {
        return false;
      }
    }
    return true;
  }

  void compareCards() {
    if (currentRoundLeader case final roundLeader?) {
      if (selectedAttribute case final attributeToCompare?) {
        final activeModeIfAny = roundLeader.$1.isSpecialModeActive
            ? roundLeader.$1.specialMode
            : null;
        final gamMode = activeModeIfAny ?? GameModeType.standard;
        final Mode modeObject;
        switch (gamMode) {
          case GameModeType.standard:
            modeObject = StandardMode(
                players: players,
                roundLeader: roundLeader.$1,
                cardAttributeType: attributeToCompare);
            final result = modeObject.result;
            for (var player in players) {
              if (player.id != result.winnerPlayer?.id) {
                player.updateHealth(-result.opponentPlayerDamage);
              }
            }
            break;
          case GameModeType.powerPlay:
            modeObject = PowerPlayMode(
                players: players,
                roundLeader: roundLeader.$1,
                cardAttributeType: attributeToCompare,
                cardAttributeType2: attributeToCompare);
            final result = modeObject.result;
            for (var player in players) {
              if (player.id != result.winnerPlayer?.id) {
                player.updateHealth(-result.opponentPlayerDamage);
              }
            }
            break;
          case GameModeType.superr:
            modeObject = SuperMode(
                players: players,
                roundLeader: roundLeader.$1,
                gameCards: roundLeader.$1.cards);
            final result = modeObject.result;
            for (var player in players) {
              if (player.id != result.winnerPlayer?.id) {
                player.updateHealth(-result.opponentPlayerDamage);
              }
            }
          case GameModeType.freeHit:
            modeObject = FreeHitMode(
                players: players,
                roundLeader: roundLeader.$1,
                cardAttributeType: attributeToCompare);
            final result = modeObject.result;
            if (result.leaderResult == ComparisonOutcome.win) {
              for (var player in players) {
                if (player.id != result.winnerPlayer?.id) {
                  player.updateHealth(-result.opponentPlayerDamage);
                }
              }
            } else {
              roundLeader.$1.updateHealth(-result.activePlayerDamage);
              for (var player in players) {
                if (player.id != roundLeader.$1.id &&
                    player.id != result.winnerPlayer?.id) {
                  player.updateHealth(-GameModeType.standard.lossDamage);
                }
              }
            }
            break;
          case GameModeType.worldCup:
            final isLastCardForActivePlayer =
                roundLeader.$1.cards.where((e) => !e.isDiscarded).length == 1;
            modeObject = WorldCupMode(
                players: players,
                roundLeader: roundLeader.$1,
                cardAttributeType: attributeToCompare,
                isLastCardForActivePlayer: isLastCardForActivePlayer);
            final result = modeObject.result;
            for (var player in players) {
              if (player.id != result.winnerPlayer?.id) {
                player.updateHealth(-result.opponentPlayerDamage);
              }
            }
            if (isLastCardForActivePlayer) {
              currentTurnPlayer.isSpecialModeActive = false;
              currentTurnPlayer.didUseSpecialMode = true;
            }
        }
        if (gamMode != GameModeType.worldCup) {
          if (currentTurnPlayer.isSpecialModeActive) {
            currentTurnPlayer.isSpecialModeActive = false;
            currentTurnPlayer.didUseSpecialMode = true;
          }
        }
      }
    }
  }

  int nextIndexInRound({required int afterIndex}) {
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
    moveTurnToNextPlayer();
  }
}


/*
Questions:
1. Free hit mode:
  - let say there are 4 players
  - according to rule, if win deals 12.5 damage to opponents and if
    lose 15 damage to self
  - If player B wins, then 
*/