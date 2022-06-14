import 'package:flutter/material.dart';
import 'package:project_v1/constants.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class Memory extends StatefulWidget {
  @override
  _MemoryState createState() => _MemoryState();
}

class _MemoryState extends State<Memory> {
  final player = AudioCache();
  GameLogic _gameLogic = GameLogic();
  int tries = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _gameLogic.initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Lpink,
      appBar: AppBar(
          foregroundColor: AppColors.black,
          actions: [
            FloatingActionButton(
              elevation: 0,
              backgroundColor: AppColors.Lpink,
              mini: true,
              child: Icon(Icons.refresh, color: AppColors.black),
              onPressed: () {
                setState(() {
                  _gameLogic.initGame();
                  tries = 0;
                  score = 0;
                });
              },
            ),
          ],
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.Lpink),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 45),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              scoreBoard("المحاولات", "$tries"),
              scoreBoard("النتيجة", "$score"),
            ],
          ),
          SizedBox(
            height: ScreenSize(context).height * 0.6,
            width: ScreenSize(context).width,
            child: GridView.builder(
                itemCount: _gameLogic.gameImg.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                ),
                padding: EdgeInsets.all(15),
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.crimson,
                        image: DecorationImage(
                            image: AssetImage(_gameLogic.gameImg[index]),
                            fit: BoxFit.contain),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.crimson,
                            blurRadius: 2,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        tries++;
                        _gameLogic.gameImg[index] = _gameLogic.cardsList[index];
                        _gameLogic.matchCheck
                            .add({index: _gameLogic.cardsList[index]});
                        print(_gameLogic.matchCheck);
                      });
                      if (_gameLogic.matchCheck.length == 2) {
                        if (_gameLogic.matchCheck[0].values.first ==
                                _gameLogic.matchCheck[1].values.first &&
                            _gameLogic.matchCheck[0].keys.first !=
                                _gameLogic.matchCheck[1].keys.first) {
                          score += 100;
                          player.play("voices/correct.mp3");
                          _gameLogic.matchCheck.clear();
                        } else {
                          player.play("voices/wrong.mp3");

                          Future.delayed(Duration(milliseconds: 500), () {
                            setState(() {
                              _gameLogic.gameImg[_gameLogic.matchCheck[0].keys
                                  .first] = _gameLogic.hiddenCardPath;
                              _gameLogic.gameImg[_gameLogic.matchCheck[1].keys
                                  .first] = _gameLogic.hiddenCardPath;
                              _gameLogic.matchCheck.clear();
                              Vibration.vibrate(duration: 300);
                            });
                          });
                        }

                        if (!_gameLogic.gameImg
                                .contains("assets/games/memo/hidden.png") &&
                            score >= 400) {
                          player.play("voices/winner.mp3");
                          Future.delayed(
                            Duration(seconds: 4),
                            () {
                              setState(() => score = 0);
                              setState(() => tries = 0);
                              setState(() => _gameLogic.initGame());
                            },
                          );
                        }
                      }
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}

Widget scoreBoard(String title, String info) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.all(25.0),
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(6.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryText(text: title, fontWeight: FontWeight.w800, size: 22),
          SizedBox(height: 10),
          PrimaryText(text: info, fontWeight: FontWeight.w800, size: 22),
        ],
      ),
    ),
  );
}

class GameLogic {
  final String hiddenCardPath = 'assets/games/memo/hidden.png';
  late List<String> gameImg;
  final cardCount = 8;

  final List<String> cardList1 = [
    "assets/games/memo/circle.png",
    "assets/games/memo/triangle.png",
    "assets/games/memo/heart.png",
    "assets/games/memo/star.png",
  ];

  final List<String> cardList2 = [
    "assets/games/memo/circle.png",
    "assets/games/memo/triangle.png",
    "assets/games/memo/heart.png",
    "assets/games/memo/star.png",
  ];
  List<String> cardsList = [];

  List<Map<int, String>> matchCheck = [];

  void fillList() {
    cardsList = [];
    cardsList += shuffle(cardList1) + shuffle(cardList2);
  }

  void initGame() {
    gameImg = List.generate(cardCount, (index) => hiddenCardPath);
    fillList();
  }
}

List<String> shuffle(List<String> items) {
  var random = new Random();

  for (var i = items.length - 1; i > 0; i--) {
    var n = random.nextInt(i + 1);
    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }
  return items;
}
