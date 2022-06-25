import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_v1/constants.dart';
import 'package:project_v1/screens/Games/memory.dart';
import 'package:project_v1/screens/animals_screen.dart';
import 'package:project_v1/screens/family_screen.dart';
import 'package:project_v1/screens/splash_screen.dart';
import 'package:project_v1/screens/main_screen.dart';
import 'package:project_v1/screens/nums_screen.dart';
import 'package:project_v1/screens/letters_screen.dart';
import 'package:project_v1/screens/Games/color_match.dart';
import 'package:project_v1/screens/games_screen.dart';
import 'package:project_v1/screens/fruits_screen.dart';
import 'package:project_v1/screens/vegetables_screen.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  // WidgetsBinding.instance!.addObserver(new MusicHandler());
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersive,
  );

  // Music().play();.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kiddo',
      theme: ThemeData(scaffoldBackgroundColor: AppColors.backGround),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(),
        '/Main': (context) => MainScreen(),
        '/Nums': (context) => NumsScreen(),
        '/Animals': (context) => AnimalScreen(),
        '/Letters': (context) => LettersScreen(),
        '/Family': (context) => FamilyScreen(),
        '/Games': (context) => GameScreen(),
        '/Color': (context) => ColorMatch(),
        '/Memory': (context) => Memory(),
        '/Fruits': (context) => Fruits(),
        '/Vegetables': (context) => Vegetables(),
      },
    );
  }
}

// class MusicHandler extends WidgetsBindingObserver {
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused) {
//       Music.music.pause();
//     } else if (state == AppLifecycleState.resumed) {
//       Music.music.resume();
//     }
//   }
// }
