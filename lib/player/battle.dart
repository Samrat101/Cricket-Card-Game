import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/game_modes/power_play_mode.dart';
import 'package:cricket_card_game/game_modes/standard_mode.dart';
import 'package:cricket_card_game/game_modes/super_mode.dart';
import 'package:cricket_card_game/interfaces/card_attribute.dart';
import 'package:cricket_card_game/interfaces/cricket_card_interface.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';
import 'package:cricket_card_game/player/player.dart';

//TODO: make health configurable via battle.
class Game {
  final List<Player> players;
  int currentLeaderIndex = 0;
  int currentTurnPlayerIndex = 0;
  CardAttribute? selectedAttribute;
  Game(this.players);
  Player get currentTurnPlayer => players[currentTurnPlayerIndex];
  Player get currentLeader => players[currentLeaderIndex];
  Player get opponent => players[(currentLeaderIndex + 1) % players.length];
  (Player player, int index)? currentRoundLeader;
  void start() {
    players[currentLeaderIndex].setAsLeader();
    players[currentTurnPlayerIndex].setAsTurnPlayer();
    currentRoundLeader =
        (players[currentTurnPlayerIndex], currentTurnPlayerIndex);
    for (var element in players[currentLeaderIndex].cards) {
      element.canSelect = true;
    }
  }

  void nextTurn() {
    selectedAttribute = null;
    currentLeader.deSetAsLeader();
    currentLeaderIndex = nextIndexInRound(afterIndex: currentLeaderIndex);
    currentLeader.setAsLeader();
    for (var element in opponent.cards) {
      if (element.isSelected) {
        element.isSelected = false;
        element.isDiscarded = true;
      }
      element.canSelect = false;
    }
    for (var element in currentLeader.cards) {
      if (element.isSelected) {
        element.isSelected = false;
        element.isDiscarded = true;
      }
      element.canSelect = true;
    }
  }

  void moveTurnToNextPlayer() {
    currentTurnPlayer.deSetAsTurnPlayer();
    currentTurnPlayerIndex =
        nextIndexInRound(afterIndex: currentTurnPlayerIndex);
    currentTurnPlayer.setAsTurnPlayer();
  }

  void resetCurrentCardsForPlayers() {
    for (var player in players) {
      player.currentCard = null;
      player.selectedAttribute = null;
    }
  }

  void updateSelectedCard(CricketCardInterface card) {
    currentTurnPlayer.currentCard = card;
    if (currentTurnPlayer.specialModeActive) {
      currentTurnPlayer.didUseSpecialMode = true;
    }
  }

  bool canChangeSpecialMode({required Player player}) {
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

  bool isLeaderCardSelected() {
    for (var card in players[currentLeaderIndex].cards) {
      if (card.isSelected) {
        return true;
      }
    }
    return false;
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
        final List<Player> tiePlayers = [];
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
        final nextIndex = nextIndexInRound(afterIndex: roundLeader.$2);
        currentRoundLeader = (players[nextIndex], nextIndex);
      }
    }
  }

  int nextIndexInRound({required int afterIndex}) {
    return (afterIndex + 1) % players.length;
  }

  void attributeSelected(String attribute) {
    for (var element in currentLeader.cards) {
      element.canSelect = false;
    }
    for (var element in opponent.cards) {
      element.canSelect = true;
    }
    switch (attribute.toLowerCase()) {
      case 'catches':
        selectedAttribute = players[currentLeaderIndex].cards[0].catches;
      case 'centuries':
        selectedAttribute = players[currentLeaderIndex].cards[0].centuries;
      case 'halfCenturies':
        selectedAttribute = players[currentLeaderIndex].cards[0].halfCenturies;
      case 'matches':
        selectedAttribute = players[currentLeaderIndex].cards[0].matches;
      case 'runs':
        selectedAttribute = players[currentLeaderIndex].cards[0].runs;
      case 'wickets':
        selectedAttribute = players[currentLeaderIndex].cards[0].wickets;
      default:
        throw Exception('Invalid attribute');
    }
    currentRoundLeader?.$1.selectedAttribute = selectedAttribute;
  }
}
