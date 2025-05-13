abstract class Player {
  final String name;
  double _health = 100;
  List<Card> _cards = []; 
  Mode? _specialMode; 

  Player(this.name);
  double get health => _health;
  List<Card> get cards => _cards;

  void dealCard(List<Card> cards) {
    _cards = cards;
  }

  void updateSpecialMode(Mode mode) {
    _specialMode = mode;
  }

  set updateHealth(double value) {
    _health = _health + value;
    if (_health < 0) {
      _health = 0;
    } else if (_health > 100) {
      _health = 100;
    } else {
      _health = value;
    }
  }

  Card playCard();
}


class Card {

}

class Mode {

}