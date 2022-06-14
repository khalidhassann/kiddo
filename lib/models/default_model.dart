import 'package:flutter/material.dart';
import 'package:project_v1/constants.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:audioplayers/audioplayers.dart';

class CustomCardModel {
  String title, image;
  CustomCardModel({
    required this.title,
    required this.image,
  });
}

class ModelStyle extends StatefulWidget {
  final CustomCardModel cardModel;
  ModelStyle({required this.cardModel});

  @override
  State<ModelStyle> createState() => _ModelStyleState();
}

class _ModelStyleState extends State<ModelStyle> {
  final FlutterTts flutterTts = FlutterTts();
  bool flag = false;
  final player = AudioCache();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 10),
            height: 230,
            child: Stack(
              children: [
                Positioned(
                  top: 30,
                  child: Container(
                    height: 180,
                    width: ScreenSize(context).width * 0.9,
                    decoration: BoxDecoration(
                      color: AppColors.pale,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  top: 2,
                  left: 10,
                  child: ShakeAnimatedWidget(
                    enabled: flag,
                    duration: Duration(milliseconds: 150),
                    shakeAngle: Rotation.deg(z: 10),
                    curve: Curves.linear,
                    child: Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          flutterTts.setLanguage("ar-EG");
                          flutterTts.speak(widget.cardModel.title);
                          flutterTts.setPitch(1);
                          setState(() => flag = true);

                          Future.delayed(Duration(milliseconds: 650), () {
                            setState(() => flag = false);
                          });
                        },
                        child: Container(
                          height: 175,
                          width: 135,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                image: AssetImage(this.widget.cardModel.image),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 190,
                  child: Container(
                    height: 125,
                    width: 160,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PrimaryText(
                            text: this.widget.cardModel.title,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            size: 33,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
