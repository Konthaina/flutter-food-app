import 'package:flutter/material.dart';

class CatagoryModel {
  String? catagoryName;
  String? iconPath;
  Color? boxColor;

  CatagoryModel({
    required this.catagoryName,
    required this.iconPath,
    required this.boxColor,
  });

  static List<CatagoryModel> getCatagoryList() {
    List<CatagoryModel> catagoryList = [];
    catagoryList.add(
      CatagoryModel(
        catagoryName: 'cat_breakfast',
        iconPath: 'assets/images/breakfast.png',
        boxColor: Colors.teal[100],
      ),
    );
    catagoryList.add(
      CatagoryModel(
        catagoryName: 'cat_noodle',
        iconPath: 'assets/images/noodles.png',
        boxColor: Colors.teal[200],
      ),
    );
    catagoryList.add(
      CatagoryModel(
        catagoryName: 'cat_hotdog',
        iconPath: 'assets/images/hot-dog.png',
        boxColor: Colors.teal[300],
      ),
    );
    catagoryList.add(
      CatagoryModel(
        catagoryName: 'cat_fries',
        iconPath: 'assets/images/french-fries.png',
        boxColor: Colors.teal[400],
      ),
    );
    return catagoryList;
  }
}
