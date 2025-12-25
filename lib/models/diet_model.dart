import 'package:flutter/material.dart';
import 'dart:ui';

class DietModel {
  final String name;
  final String iconPath;
  final String lavel;
  final String duration;
  final String calorie;
  final bool viewIsSelected;

  DietModel({
    required this.name,
    required this.iconPath,
    required this.lavel,
    required this.duration,
    required this.calorie,
    required this.viewIsSelected,
  });

  Color? get boxColor => viewIsSelected ? Color(0xFFB2DFDB) : Color(0xFFE0F2F1);

  static List<DietModel> getDietList() {
    List<DietModel> dietList = [];
    dietList.add(
      DietModel(
        name: 'សាច់មាន់ចៀន', // "Grilled Chicken" in Khmer
        iconPath: 'assets/images/roast-chicken.png',
        lavel: 'ងាយ', // "Easy" in Khmer
        duration: '10 mins',
        calorie: '150 kcal',
        viewIsSelected: true,
      ),
    );
    dietList.add(
      DietModel(
        name: 'ត្រីសាច់ដុត', // "Grilled Fish" in Khmer
        iconPath: 'assets/images/fish.png',
        lavel: 'មធ្យម', // "Medium" in Khmer
        duration: '20 mins',
        calorie: '250 kcal',
        viewIsSelected: false,
      ),
    );
    dietList.add(
      DietModel(
        name: 'ក្រូសង់', // "Croissant" in Khmer
        iconPath: 'assets/images/croissant.png',
        lavel: 'ពិបាក', // "Hard" in Khmer
        duration: '15 mins',
        calorie: '100 kcal',
        viewIsSelected: false,
      ),
    );
    return dietList;
  }
}
