import 'package:cricket_card_game/interfaces/card_attribute.dart';
import 'package:cricket_card_game/interfaces/cricket_card_interface.dart';

class CricketCard implements CricketCardInterface {
  final CardAttribute _catches;
  final CardAttribute _centuries;
  final CardAttribute _halfCenturies;
  final CardAttribute _matches;
  final CardAttribute _runs;
  final CardAttribute _wickets;
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
  CricketCard({
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
        _wickets = wickets;
}
