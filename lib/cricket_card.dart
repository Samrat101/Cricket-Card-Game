import 'package:cricket_card_game/interfaces/cricket_card_interface.dart';

class CricketCard implements CricketCardInterface {
  final int _runs;
  final int _matches;
  final int _centuries;
  final int _halfCenturies;
  final int _catches;
  final int _wickets;

  /// Range from 0 to 100,000
  @override
  int get runs => _runs;

  /// Range from 0 to 500
  @override
  int get matches => _matches;

  /// Range from 0 to 100
  @override
  int get centuries => _centuries;

  /// Range from 0 to 80
  @override
  int get halfCenturies => _halfCenturies;

  /// Range from 0 to 380
  @override
  int get catches => _catches;

  /// Range from 0 to 960
  @override
  int get wickets => _wickets;

  CricketCard({
    required int runs,
    required int matches,
    required int centuries,
    required int halfCenturies,
    required int catches,
    required int wickets,
  })  : _runs = runs,
        _matches = matches,
        _centuries = centuries,
        _halfCenturies = halfCenturies,
        _catches = catches,
        _wickets = wickets;
}
