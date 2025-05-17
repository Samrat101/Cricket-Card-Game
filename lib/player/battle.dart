import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/game_modes/power_play_mode.dart';
import 'package:cricket_card_game/game_modes/standard_mode.dart';
import 'package:cricket_card_game/game_modes/super_mode.dart';
import 'package:cricket_card_game/interfaces/card/card_attribute.dart';
import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
import 'package:cricket_card_game/player/player.dart';

//TODO: make health configurable via battle.
class Game {
  final List<PlayerInterface> players;
  int currentTurnPlayerIndex = 0;
  CardAttribute? selectedAttribute;
  Game(this.players);
  PlayerInterface get currentTurnPlayer => players[currentTurnPlayerIndex];
  PlayerInterface get nextTurnPlayer =>
      players[nextIndexInRound(afterIndex: currentTurnPlayerIndex)];
  (PlayerInterface player, int index)? currentRoundLeader;
  (PlayerInterface player, int index) get nextRoundLeader => (
        players[nextIndexInRound(afterIndex: currentRoundLeader!.$2)],
        nextIndexInRound(afterIndex: currentRoundLeader!.$2)
      );
  void start() {
    players[currentTurnPlayerIndex].isTurnActive = true;
    players[currentTurnPlayerIndex].isTurnActive = true;
    currentRoundLeader =
        (players[currentTurnPlayerIndex], currentTurnPlayerIndex);
    for (var element in players[currentTurnPlayerIndex].cards) {
      element.canSelect = true;
    }
  }

  void nextTurn() {
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

    for (var element in nextRoundLeader.$1.cards) {
      element.canSelect = true;
    }

    currentTurnPlayer.isTurnActive = false;
    currentTurnPlayerIndex = nextRoundLeader.$2;
    currentTurnPlayer.isTurnActive = true;
    currentRoundLeader =
        (players[currentTurnPlayerIndex], currentTurnPlayerIndex);
  }

  void moveTurnToNextPlayer() {
    for (var element in nextTurnPlayer.cards) {
      element.canSelect = true;
    }
    for (var element in currentTurnPlayer.cards) {
      element.canSelect = false;
    }
    currentTurnPlayer.isTurnActive = false;
    currentTurnPlayerIndex =
        nextIndexInRound(afterIndex: currentTurnPlayerIndex);
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
    if (currentTurnPlayer.isSpecialModeActive) {
      currentTurnPlayer.didUseSpecialMode = true;
    }
  }

  void cardSelectedCallback(CricketCardInterface card) {
    updateSelectedCard(card);
    if (allCardsSelected()) {
      compareCards();
      resetCurrentCardsForPlayers();
      nextTurn();
      return;
    }
    for (var element in currentTurnPlayer.cards) {
      if (element != card) {
        element.updateCardSelectedStatus(false);
      }
    }
    moveTurnToNextPlayer();
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

  bool allCardsSelected() {
    for (var player in players) {
      if (player.cards.any((card) => card.isSelected)) {
        continue;
      } else {
        return false;
      }
    }
    return true;
  }

//TODO break this function.
  void compareCards() {
    if (currentRoundLeader case final roundLeader?) {
      final attributeToCompare = selectedAttribute;
      final activeModeIfAny = roundLeader.$1.isSpecialModeActive
          ? roundLeader.$1.specialMode
          : null;
      if (attributeToCompare != null) {
        final List<PlayerInterface> tiePlayers = [];
        final winner = players.reduce((player, nextPlayer) {
          final Mode userSelectedMode;
          final playerAttribute = player.currentCard!
              .getAttribute(withValue: attributeToCompare.code);
          final nextPlayerAttribute = nextPlayer.currentCard!
              .getAttribute(withValue: attributeToCompare.code);
          switch (activeModeIfAny) {
            case SpecialMode.powerPlayMode:
              userSelectedMode = PowerPlayMode(
                playerAttribute,
                nextPlayerAttribute,
                playerAttribute,
                nextPlayerAttribute,
              );
              break;
            case SpecialMode.superMode:
              userSelectedMode = SuperMode(player.cards, nextPlayer.cards);
              break;
            case SpecialMode.freeHitMode:
              userSelectedMode = SuperMode(player.cards, nextPlayer.cards);
              break;
            default:
              userSelectedMode =
                  StandardMode(playerAttribute, nextPlayerAttribute);
          }
          final comparisonResult = userSelectedMode.result;
          switch (comparisonResult.result) {
            case ComparisonOutcome.win:
              return player;
            case ComparisonOutcome.loss:
              return nextPlayer;
            case ComparisonOutcome.tie:
              tiePlayers.add(player);
              tiePlayers.add(nextPlayer);
              return player;
          }
        });
        final gamMode = activeModeIfAny?.gameModeType ?? GameModeType.standard;
        for (var player in players) {
          if (player.name != winner.name) {
            player.updateHealth(-gamMode.lossDamage);
          }
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
    for (var element in currentRoundLeader!.$1.cards) {
      element.canSelect = false;
    }
    for (var element in currentTurnPlayer.cards) {
      element.canSelect = true;
    }
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
