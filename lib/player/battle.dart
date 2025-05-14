import 'package:cricket_card_game/player/player.dart';

class Game {
  final List<Player> players;
  int currentPlayerIndex = 0;
  int turnNumber = 1;

  Game(this.players);

  void start() {
    Player activePlayer = players.first;
    activePlayer.setMyTurn(true);
    while (players.firstWhere((player) => player.health != 0) == null) {
     CricketCard activePlayerCard = activePlayer.playCard();
    }
  }

  void startNextTurn() {
    print('--- Turn $turnNumber ---');
    currentPlayerIndex = 0;
    _takeNextPlayerTurn();
  }

  void _takeNextPlayerTurn() {
    if (currentPlayerIndex < players.length) {
      final player = players[currentPlayerIndex];
      player.playCard();

      // Proceed to the next player's turn
      currentPlayerIndex++;
      _takeNextPlayerTurn(); // You can delay this if you're in UI
    } else {
      print('Turn $turnNumber complete');
      turnNumber++;
    }
  }
}
