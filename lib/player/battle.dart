import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/game_modes/free_hit_mode.dart';
import 'package:cricket_card_game/game_modes/power_play_mode.dart';
import 'package:cricket_card_game/game_modes/standard_mode.dart';
import 'package:cricket_card_game/game_modes/super_mode.dart';
import 'package:cricket_card_game/game_modes/world_cup_mode.dart';
import 'package:cricket_card_game/interfaces/card/card_attribute.dart';
import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
import 'package:cricket_card_game/player/player_interface.dart';

//TODO: make health configurable via battle.
class Game {
  final List<PlayerInterface> players;
  int _currentTurnPlayerIndex = 0;
  CardAttribute? selectedAttribute;
  Game(this.players);
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
      player.selectedAttribute = null;
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
        final List<PlayerInterface> tiePlayers = [];
        final winner = players.reduce((player, nextPlayer) {
          final Mode userSelectedMode;
          final playerAttribute = player.currentCard!
              .getAttribute(withValue: attributeToCompare.code);
          final nextPlayerAttribute = nextPlayer.currentCard!
              .getAttribute(withValue: attributeToCompare.code);
          switch (activeModeIfAny) {
            case GameModeType.powerPlay:
              userSelectedMode = PowerPlayMode(
                playerAttribute,
                nextPlayerAttribute,
                playerAttribute,
                nextPlayerAttribute,
              );
              break;
            case GameModeType.superr:
              userSelectedMode = SuperMode(player.cards, nextPlayer.cards);
              break;
            case GameModeType.freeHit:
              userSelectedMode = FreeHitMode(
                  player1CardAttribute: playerAttribute,
                  player2CardAttribute: nextPlayerAttribute);
              break;
            case GameModeType.worldCup:
              final isLastCard = player.cards.length == 1;
              userSelectedMode = WorldCupMode(
                  player1CardAttribute: playerAttribute,
                  player2CardAttribute: nextPlayerAttribute,
                  isLastCardForActivePlayer: isLastCard);
            default:
              userSelectedMode = StandardMode(
                  player1CardAttribute: playerAttribute,
                  player2CardAttribute: nextPlayerAttribute);
          }
          final comparisonResult = userSelectedMode.result;
          switch (comparisonResult.result) {
            case ComparisonOutcome.win:
              return player;
            case ComparisonOutcome.loss:
              return nextPlayer;
            case ComparisonOutcome.tie:
              tiePlayers.addAll([player, nextPlayer]);
              return player;
          }
        });
        final gamMode = activeModeIfAny ?? GameModeType.standard;
        for (var player in players) {
          if (player.name != winner.name) {
            player.updateHealth(-gamMode.lossDamage);
          }
        }
        if (currentTurnPlayer.isSpecialModeActive) {
          currentTurnPlayer.isSpecialModeActive = false;
          currentTurnPlayer.didUseSpecialMode = true;
        }
      }
    }
  }

  int nextIndexInRound({required int afterIndex}) {
    return (afterIndex + 1) % players.length;
  }

  void attributeSelected(String attribute) {
    if (currentRoundLeader == null) {
      return;
    }
    moveTurnToNextPlayer();
    switch (attribute.toLowerCase()) {
      case 'catches':
        selectedAttribute = currentRoundLeader!.$1.currentCard?.catches;
      case 'centuries':
        selectedAttribute = currentRoundLeader!.$1.currentCard?.centuries;
      case 'halfCenturies':
        selectedAttribute = currentRoundLeader!.$1.currentCard?.halfCenturies;
      case 'matches':
        selectedAttribute = currentRoundLeader!.$1.currentCard?.matches;
      case 'runs':
        selectedAttribute = currentRoundLeader!.$1.currentCard?.runs;
      case 'wickets':
        selectedAttribute = currentRoundLeader!.$1.currentCard?.wickets;
      default:
        throw Exception('Invalid attribute');
    }
    currentRoundLeader!.$1.selectedAttribute = selectedAttribute;
  }
}
