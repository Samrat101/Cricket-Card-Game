import 'package:cricket_card_game/enums.dart';
import 'package:cricket_card_game/player/player_interface.dart';
import 'package:flutter/material.dart';

class ModeDialog extends StatefulWidget {
  final PlayerInterface player;
  const ModeDialog({required this.player});

  @override
  _ModeDialogState createState() => _ModeDialogState();
}

class _ModeDialogState extends State<ModeDialog> {
  String? _selectedMode;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.player.name}, select your special mode'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: GameModeType.specialModes.map((mode) {
          return RadioListTile<String>(
            title: Text(mode.displayName),
            value: mode.displayName,
            groupValue: _selectedMode,
            onChanged: (value) {
              setState(() {
                _selectedMode = value;
              });
            },
          );
        }).toList(),
      ),
      actions: [
        ElevatedButton(
          onPressed: _selectedMode != null
              ? () => Navigator.of(context).pop(_selectedMode)
              : null,
          child: const Text('Select Mode'),
        ),
      ],
    );
  }
}
