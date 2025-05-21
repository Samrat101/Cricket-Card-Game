import 'package:cricket_card_game/cricket_card_attribute.dart';
import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/interfaces/card/card_attribute.dart';
import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';
import 'package:uuid/uuid.dart';

class CricketCard implements CricketCardInterface {
  final CardAttribute _catches;
  final CardAttribute _centuries;
  final CardAttribute _halfCenturies;
  final CardAttribute _matches;
  final CardAttribute _runs;
  final CardAttribute _wickets;
  final String _playerName;
  bool _isSelected = false;
  bool _canSelect = false;
  bool _isDiscarded = false;
  final String _id;
  @override
  bool get isSelected => _isSelected;
  @override
  bool get canSelect => _canSelect;
  @override
  bool get isDiscarded => _isDiscarded;
  @override
  CardAttribute get catches => _catches;
  @override
  CardAttribute get centuries => _centuries;
  @override
  CardAttribute get halfCenturies => _halfCenturies;
  @override
  CardAttribute get matches => _matches;
  @override
  CardAttribute get runs => _runs;
  @override
  CardAttribute get wickets => _wickets;
  @override
  String get playerName => _playerName;
  @override
  set canSelect(bool value) => _canSelect = value;
  @override
  set isDiscarded(bool value) => _isDiscarded = value;

  @override
  void updateCardSelectedStatus(bool status) {
    _isSelected = status;
  }

  CricketCard({
    required String playerName,
    required CardAttribute catches,
    required CardAttribute centuries,
    required CardAttribute halfCenturies,
    required CardAttribute matches,
    required CardAttribute runs,
    required CardAttribute wickets,
  })  : _catches = catches,
        _centuries = centuries,
        _halfCenturies = halfCenturies,
        _matches = matches,
        _runs = runs,
        _wickets = wickets,
        _playerName = playerName,
        _id = const Uuid().v4();

  factory CricketCard.fromJson(Map<String, dynamic> json) {
    return CricketCard(
      playerName: json['player_name'],
      catches: CricketCardAttribute.fromJson(json['catches']),
      centuries: CricketCardAttribute.fromJson(json['centuries']),
      halfCenturies: CricketCardAttribute.fromJson(json['half_centuries']),
      matches: CricketCardAttribute.fromJson(json['matches']),
      runs: CricketCardAttribute.fromJson(json['runs']),
      wickets: CricketCardAttribute.fromJson(json['wickets']),
    );
  }

  @override
  CardAttribute getAttribute({required String withValue}) {
    final cardAttributeType = CardAttributeType.from(withValue);
    if (cardAttributeType == null) {
      throw Exception('Invalid attribute type');
    }
    switch (cardAttributeType) {
      case CardAttributeType.catches:
        return catches;
      case CardAttributeType.centuries:
        return centuries;
      case CardAttributeType.halfCenturies:
        return halfCenturies;
      case CardAttributeType.matches:
        return matches;
      case CardAttributeType.runs:
        return runs;
      case CardAttributeType.wickets:
        return wickets;
      default:
        throw Exception('Invalid attribute');
    }
  }

  @override
  String get id => _id;
}
