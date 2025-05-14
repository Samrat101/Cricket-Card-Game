import 'package:cricket_card_game/enums.dart';

class CardAttribute {
  final String code;
  final String description;
  final Comparable value;
  ComparisionWin comparisionType;
  CardAttribute(
      {required this.code,
      required this.description,
      required this.value,
      required this.comparisionType});

  void updateComparator(ComparisionWin newComparator) {
    comparisionType = newComparator;
  }

  factory CardAttribute.fromJson(Map<String, dynamic> json) {
    return CardAttribute(
      code: json['code'],
      description: json['description'],
      value: json['value'],
      comparisionType: ComparisionWin.from(
          (json['comparision_type'] as String?) ?? 'greater'),
    );
  }
}
