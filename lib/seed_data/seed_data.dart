import 'package:cricket_card_game/cricket_card.dart';
import 'package:cricket_card_game/interfaces/card/cricket_card_interface.dart';

abstract class DataService {
  List<CricketCardInterface> getData();
  factory DataService() {
    return SeedData();
  }
}
class SeedData implements DataService {
  final List<Map<String, dynamic>> _cards = [
    {
      'player_name': 'Virat Kohli',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 140,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 76,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 65,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 280,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 13000,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 5,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'MS Dhoni',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 320,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 10,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 73,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 350,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 10500,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 1,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'Sachin Tendulkar',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 140,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 100,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 96,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 463,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 18426,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 154,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'Rohit Sharma',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 150,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 45,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 53,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 250,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 11000,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 8,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'Ravindra Jadeja',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 120,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 3,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 35,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 150,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 3000,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 200,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'KL Rahul',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 70,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 15,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 25,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 90,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 4000,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 0,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'Shubman Gill',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 35,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 8,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 12,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 60,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 3000,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 0,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'Hardik Pandya',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 65,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 2,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 10,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 70,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 1600,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 70,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'Yuzvendra Chahal',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 20,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 0,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 0,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 80,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 100,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 120,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'Bhuvneshwar Kumar',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 35,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 0,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 2,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 130,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 500,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 150,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'David Warner',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 120,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 48,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 60,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 320,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 12000,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 0,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'Joe Root',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 130,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 45,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 60,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 290,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 11000,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 40,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'Kane Williamson',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 90,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 41,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 55,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 250,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 9500,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 37,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'Steve Smith',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 170,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 44,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 58,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 300,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 10500,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 30,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'Ben Stokes',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 100,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 15,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 30,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 170,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 5000,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 120,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'Quinton de Kock',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 200,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 21,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 34,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 150,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 7500,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 0,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'Jasprit Bumrah',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 25,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 0,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 0,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 100,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 200,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 180,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'Marnus Labuschagne',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 50,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 15,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 20,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 90,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 4500,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 20,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'Shaheen Afridi',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 15,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 0,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 1,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 70,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 250,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 140,
        'comparision_type': 'greater'
      },
    },
    {
      'player_name': 'Mohammad Rizwan',
      'catches': {
        'code': 'catches',
        'description': 'Number of catches',
        'value': 90,
        'comparision_type': 'greater'
      },
      'centuries': {
        'code': 'centuries',
        'description': 'Number of centuries',
        'value': 10,
        'comparision_type': 'greater'
      },
      'half_centuries': {
        'code': 'half_centuries',
        'description': 'Number of half centuries',
        'value': 25,
        'comparision_type': 'greater'
      },
      'matches': {
        'code': 'matches',
        'description': 'Number of matches',
        'value': 100,
        'comparision_type': 'greater'
      },
      'runs': {
        'code': 'runs',
        'description': 'Number of runs',
        'value': 4000,
        'comparision_type': 'greater'
      },
      'wickets': {
        'code': 'wickets',
        'description': 'Number of wickets',
        'value': 0,
        'comparision_type': 'greater'
      },
    }
  ];

  @override
  List<CricketCardInterface> getData() {
    return List<CricketCard>.from(
      _cards.map((e) => CricketCard.fromJson(e)),
    );
  }
}
