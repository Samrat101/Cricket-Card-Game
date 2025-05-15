import 'package:cricket_card_game/cricket_card.dart';
import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/interfaces/card_attribute.dart';
import 'package:cricket_card_game/interfaces/cricket_card_interface.dart';

abstract class Player {
  final String name;
  bool _currentLeader = false;
  bool _isTurnPlayer = false;
  double _health = 100;
  List<CricketCardInterface> _cards = [];
  SpecialMode? _specialMode;
  bool specialModeActive = false;

  Player(this.name);
  double get health => _health;
  bool get isCurrentLeader => _currentLeader;
  bool get isTurnPlayer => _isTurnPlayer;
  List<CricketCardInterface> get cards => _cards;
  SpecialMode? get specialMode => _specialMode;
  bool get isSpecialModeActive => specialModeActive;
  bool didUseSpecialMode = false;
  CricketCardInterface? currentCard;
  CardAttribute? selectedAttribute;
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

  void toggleSpecialMode() {
    if (specialModeActive) {
      deActivateSpecialMode();
    } else {
      activateSpecialMode();
    }
  }

  void setAsLeader() {
    _currentLeader = true;
  }

  void deSetAsLeader() {
    _currentLeader = false;
  }

  void setAsTurnPlayer() {
    _isTurnPlayer = true;
  }

  void deSetAsTurnPlayer() {
    _isTurnPlayer = false;
  }

  void updateHealth(double value) {
    _health = _health + value;
    if (_health < 0) {
      _health = 0;
    } else if (_health > 100) {
      _health = 100;
    }
  }

  CricketCardInterface playCard();
}
