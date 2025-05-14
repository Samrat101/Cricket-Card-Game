import 'package:cricket_card_game/screens/game_screen.dart';

abstract class Player {
  final String name;
  bool _myTurn = false;
  double _health = 100;
  List<CricketCard> _cards = [];
  SpecialMode? _specialMode;
  bool specialModeActive = false;

  Player(this.name);
  double get health => _health;
  bool get myTurn => _myTurn;
  List<CricketCard> get cards => _cards;
  SpecialMode? get specialMode => _specialMode;
  bool get isSpecialModeActive => specialModeActive;
  
  void dealCard(List<CricketCard> cards) {
    _cards = cards;
  }

  void updateSpecialMode(SpecialMode mode) {
    _specialMode = mode;
  }

  void activateSpecialMode() {
    if (_specialMode != null) {
      specialModeActive = true;
    }
  }

  void deActivateSpecialMode() {
    if (_specialMode != null) {
      specialModeActive = false;
    }
  }

  void setMyTurn(bool value) {
    _myTurn = value;
  }

  void updateHealth(double value) {
    _health = _health + value;
    if (_health < 0) {
      _health = 0;
    } else if (_health > 100) {
      _health = 100;
    } else {
      _health = value;
    }
  }

  CricketCard playCard();
}

class CricketCard {
  bool isSelected = false;
}

class Mode {}
