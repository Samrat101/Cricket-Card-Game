import 'package:cricket_card_game/player/player.dart';
import 'package:flutter/material.dart';

class PlayerCard extends StatefulWidget {
  final Player player;
  const PlayerCard({super.key, required this.player});

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.player.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            if (widget.player.specialMode != null)
              Row(
                children: [
                  Text(widget.player.specialMode!.displayName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      if (widget.player.specialModeActive) {
                        widget.player.deActivateSpecialMode();
                      } else {
                        widget.player.activateSpecialMode();
                      }
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            widget.player.specialModeActive
                                ? 'Deactivate'
                                : 'Activate',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: widget.player.health / 100,
                minHeight: 12,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
