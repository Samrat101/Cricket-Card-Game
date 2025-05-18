import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';

abstract class PlayerInterface {
  String get id;
  String get name;
  bool get isTurnActive;
  double get health;
  List<CricketCardInterface> get cards;
  GameModeType? get specialMode;
  bool get isSpecialModeActive;
  bool get didUseSpecialMode;
  CricketCardInterface? get currentCard;

  set cards(List<CricketCardInterface> cards);
  set specialMode(GameModeType? mode);
  set isSpecialModeActive(bool value);
  set didUseSpecialMode(bool value);
  set currentCard(CricketCardInterface? card);
  set isTurnActive(bool value);
  void updateHealth(double value);
  void toggleSpecialMode();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PlayerInterface) return false;
    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
