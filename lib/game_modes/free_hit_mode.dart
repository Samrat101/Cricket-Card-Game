import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/game_modes/standard_mode.dart';
import 'package:cricket_card_game/interfaces/game_mode.dart';

/// Player deals 12.5% damage when winning but takes 15% damage when losing
class FreeHitMode extends StandardMode implements GameLevelMode {
  @override
  double get opponentDamage => GameModeType.freeHit.winDamage;
  @override
  double get activePlayerDamage => GameModeType.freeHit.lossDamage;
  FreeHitMode({
    required super.cards,
    required super.roundLeaderCard,
    required super.cardAttributeType,
  });
}
