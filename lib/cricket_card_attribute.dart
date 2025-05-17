import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/interfaces/card/card_attribute.dart';

class CricketCardAttribute implements CardAttribute {
  @override
  final String code;
  @override
  final String description;
  @override
  final Comparable value;
  @override
  ComparisionWin get comparisionType => _comparisionType;
  ComparisionWin _comparisionType;

  CricketCardAttribute({
    required this.code,
    required this.description,
    required this.value,
    required ComparisionWin comparisionType,
  }) : _comparisionType = comparisionType;

  factory CricketCardAttribute.fromJson(Map<String, dynamic> json) {
    return CricketCardAttribute(
      code: json['code'],
      description: json['description'],
      value: json['value'],
      comparisionType: ComparisionWin.from(
          (json['comparision_type'] as String?) ?? 'greater'),
    );
  }

  @override
  void updateComparator(ComparisionWin newComparator) {
    _comparisionType = newComparator;
  }
}
