import 'package:flutter/material.dart';
import 'package:project_v1/constants.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:animated_widgets/animated_widgets.dart';

class CustomCardModel {
  String title, subImage, image;
  CustomCardModel({
    required this.title,
    required this.subImage,
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
                      color: AppColors.crimson,
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
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          //Music().volDown();
                          flutterTts.setLanguage("ar-EG");
                          flutterTts.speak(widget.cardModel.title);
                          flutterTts.setPitch(1);
                          setState(() => flag = true);

                          Future.delayed(Duration(milliseconds: 650), () {
                            setState(() => flag = false);
                          });

                          // Future.delayed(Duration(milliseconds: 900), () {
                          //   Music().volUp();
                          // });
                        },
                        child: Container(
                          height: 175,
                          width: 135,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.white.withOpacity(0.3),
                                  spreadRadius: 2.5,
                                  blurRadius: 4,
                                  offset: Offset(0.5, 1.5))
                            ],
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
                  top: 55,
                  left: 200,
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
                            size: 35,
                          ),
                          Container(
                            height: 65,
                            width: 65,
                            child: Image(
                                image:
                                    AssetImage(this.widget.cardModel.subImage),
                                fit: BoxFit.contain),
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
