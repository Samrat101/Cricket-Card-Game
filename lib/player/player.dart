import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/interfaces/card/card_attribute.dart';
import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';
import 'package:cricket_card_game/player/player_interface.dart';

class Player implements PlayerInterface {
  @override
  final String name;
  bool _isTurnActive = false;
  double _health = 100;
  List<CricketCardInterface> _cards = [];
  SpecialMode? _specialMode;
  bool _isSpecialModeActive = false;
  bool _didUseSpecialMode = false;
  CricketCardInterface? _currentCard;
  CardAttribute? _selectedAttribute;

  Player(this.name);
  @override
  bool get isTurnActive => _isTurnActive;
  @override
  double get health => _health;
  @override
  List<CricketCardInterface> get cards => _cards;
  @override
  SpecialMode? get specialMode => _specialMode;
  @override
  bool get isSpecialModeActive => _isSpecialModeActive;
  @override
  bool get didUseSpecialMode => _didUseSpecialMode;
  @override
  CricketCardInterface? get currentCard => _currentCard;
  @override
  CardAttribute? get selectedAttribute => _selectedAttribute;

  @override
  set cards(List<CricketCardInterface> value) {
    _cards = value;
  }

  @override
  set specialMode(SpecialMode? value) {
    _specialMode = value;
  }

  @override
  set didUseSpecialMode(bool value) {
    _didUseSpecialMode = value;
  }

  @override
  set isSpecialModeActive(bool value) {
    _isSpecialModeActive = value;
  }

  @override
  void toggleSpecialMode() {
    if (isSpecialModeActive) {
      isSpecialModeActive = false;
    } else {
      isSpecialModeActive = true;
    }
  }

  @override
  set isTurnActive(bool value) {
    _isTurnActive = value;
  }

  @override
  set currentCard(CricketCardInterface? card) {
    _currentCard = card;
  }

  @override
  set selectedAttribute(CardAttribute? attribute) {
    _selectedAttribute = attribute;
  }

  @override
  void updateHealth(double value) {
    _health = _health + value;
    if (_health < 0) {
      _health = 0;
    } else if (_health > 100) {
      _health = 100;
    }
  }
}
