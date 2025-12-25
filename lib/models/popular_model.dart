class PopularModel {
  String name;
  String iconPath;
  String duration;
  String calorie;
  bool boxIsSelected;

  PopularModel({
    required this.name,
    required this.iconPath,
    required this.duration,
    required this.calorie,
    this.boxIsSelected = false,
  });

  static List<PopularModel> getPopularList() {
    List<PopularModel> popularList = [];
    popularList.add(
      PopularModel(
        name: 'សាច់មាន់ចៀន', // "Grilled Chicken" in Khmer
        iconPath: 'assets/images/roast-chicken.png',
        duration: '10 mins',
        calorie: '150 kcal',
        boxIsSelected: false,
      ),
    );
    popularList.add(
      PopularModel(
        name: 'ត្រីសាច់ដុត', // "Grilled Fish" in Khmer
        iconPath: 'assets/images/fish.png',
        duration: '20 mins',
        calorie: '250 kcal',
        boxIsSelected: true,
      ),
    );
    popularList.add(
      PopularModel(
        name: 'ក្រូសង់', // "Croissant" in Khmer
        iconPath: 'assets/images/croissant.png',
        duration: '15 mins',
        calorie: '100 kcal',
        boxIsSelected: false,
      ),
    );
    popularList.add(
      PopularModel(
        name: 'គុយទាវ', // "Noodle Soup" in Khmer
        iconPath: 'assets/images/noodles.png',
        duration: '5 mins',
        calorie: '80 kcal',
        boxIsSelected: false,
      ),
    );
    return popularList;
  }
}
