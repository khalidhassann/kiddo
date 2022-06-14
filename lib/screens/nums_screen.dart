import 'package:flutter/material.dart';
import 'package:project_v1/constants.dart';
import 'package:project_v1/models/model_nums.dart';

class NumsScreen extends StatefulWidget {
  @override
  _NumsScreenState createState() => _NumsScreenState();
}

class _NumsScreenState extends State<NumsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.backGround),
        ),
        title:
            Image.asset('assets/images/Logo_color.png', width: 65, height: 65),
      ),
      backgroundColor: AppColors.black,
      body: Center(
        child: buildModels(),
      ),
    );
  }

  Widget buildModels() {
    return ListView.builder(
      itemCount: numsList.length,
      itemBuilder: (context, index) {
        return ModelStyle(
          cardModel: new CustomCardModel(
              title: numsList[index]['name'].toString(),
              subImage: numsList[index]['counterPath'].toString(),
              image: numsList[index]['imagePath'].toString()),
        );
      },
    );
  }
}
