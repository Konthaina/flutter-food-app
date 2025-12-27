import 'package:flutter/material.dart';
import 'dart:ui';

class DietModel {
  final String name;
  final String iconPath;
  final String lavel;
  final String duration;
  final String calorie;
  final String price;
  final bool viewIsSelected;

  DietModel({
    required this.name,
    required this.iconPath,
    required this.lavel,
    required this.duration,
    required this.calorie,
    required this.price,
    required this.viewIsSelected,
  });

  Color? get boxColor => viewIsSelected ? Color(0xFFB2DFDB) : Color(0xFFE0F2F1);

  static List<DietModel> getDietList() {
    List<DietModel> dietList = [];
    dietList.add(
      DietModel(
        name: 'diet_chicken',
        iconPath: 'assets/images/roast-chicken.png',
        lavel: 'level_easy',
        duration: '10 mins',
        calorie: '150 kcal',
        price: '12.00',
        viewIsSelected: true,
      ),
    );
    dietList.add(
      DietModel(
        name: 'diet_fish',
        iconPath: 'assets/images/fish.png',
        lavel: 'level_medium',
        duration: '20 mins',
        calorie: '250 kcal',
        price: '15.50',
        viewIsSelected: false,
      ),
    );
    dietList.add(
      DietModel(
        name: 'diet_croissant',
        iconPath: 'assets/images/croissant.png',
        lavel: 'level_hard',
        duration: '15 mins',
        calorie: '100 kcal',
        price: '2.50',
        viewIsSelected: false,
      ),
    );
    return dietList;
  }
}
