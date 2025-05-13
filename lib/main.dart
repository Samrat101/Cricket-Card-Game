import 'package:flutter/material.dart';

void main() => runApp(CricketCardsGameApp());

class CricketCardsGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cricket Cards Game',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: CricketCardsGameUI(),
    );
  }
}

class CricketCardsGameUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cricket Cards Game'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          PlayerSection(playerName: 'Player 1'),
          Expanded(
            child: Center(
              child: SelectedCardsBoard(),
            ),
          ),
          PlayerSection(playerName: 'Player 2'),
        ],
      ),
    );
  }
}

class PlayerSection extends StatelessWidget {
  final String playerName;

  const PlayerSection({required this.playerName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          playerName,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 100,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 4.0,
            ),
            itemBuilder: (context, index) {
              return Card(
                color: Colors.orangeAccent,
                child: Center(
                  child: Text(
                    'Card ${index + 1}',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SelectedCardsBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Selected Cards',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              color: Colors.lightBlue[100],
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Player 1 Card'),
              ),
            ),
            Text('VS'),
            Card(
              color: Colors.lightGreen[100],
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Player 2 Card'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
