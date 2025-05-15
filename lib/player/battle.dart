import 'package:cricket_card_game/interfaces/card_attribute.dart';
import 'package:cricket_card_game/interfaces/cricket_card_interface.dart';
import 'package:cricket_card_game/player/player.dart';

class Game {
  final List<Player> players;
  int currentLeaderIndex = 0;
  CardAttribute? selectedAttribute;
  Game(this.players);
  Player get currentLeader => players[currentLeaderIndex];
  Player get opponent => players[(currentLeaderIndex + 1) % players.length];

  void start() {
    players[currentLeaderIndex].setAsLeader();
    for (var element in players[currentLeaderIndex].cards) {
      element.canSelect = true;
    }
  }

  void nextTurn() {
    selectedAttribute = null;
    currentLeader.deSetAsLeader();
    currentLeaderIndex = (currentLeaderIndex + 1) % players.length;
    currentLeader.setAsLeader();
    for (var element in opponent.cards) {
      element.canSelect = false;
    }
    for (var element in currentLeader.cards) {
      element.canSelect = true;
    }
  }

  void setCurrentLeaderCard(CricketCardInterface card) {
    currentLeader.currentCard = card;
  }

  void resetCurrentCardsForPlayers() {
    for (var player in players) {
      player.currentCard = null;
    }
  }

  bool canChangeSpecialMode({required Player player}) {
    return player.isCurrentLeader && !isRoundInProgress();
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

  void compareCards() {
    currentLeader.updateHealth(-10);
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
  }
}
