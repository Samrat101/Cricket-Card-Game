import 'package:cricket_card_game/screens/start_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CricketCardGameApp());
}

class CricketCardGameApp extends StatelessWidget {
  const CricketCardGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cricket Card Game',
      theme: ThemeData(primarySwatch: Colors.green),
      home: GameStartScreen(),
    );
  }
}

