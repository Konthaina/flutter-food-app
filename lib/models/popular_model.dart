class PopularModel {
  String name;
  String iconPath;
  String duration;
  String calorie;
  String price;
  bool boxIsSelected;

  PopularModel({
    required this.name,
    required this.iconPath,
    required this.duration,
    required this.calorie,
    required this.price,
    this.boxIsSelected = false,
  });

  static List<PopularModel> getPopularList() {
    List<PopularModel> popularList = [];
    popularList.add(
      PopularModel(
        name: 'diet_chicken',
        iconPath: 'assets/images/roast-chicken.png',
        duration: '10 mins',
        calorie: '150 kcal',
        price: '12.00',
        boxIsSelected: false,
      ),
    );
    popularList.add(
      PopularModel(
        name: 'diet_fish',
        iconPath: 'assets/images/fish.png',
        duration: '20 mins',
        calorie: '250 kcal',
        price: '15.50',
        boxIsSelected: true,
      ),
    );
    popularList.add(
      PopularModel(
        name: 'diet_croissant',
        iconPath: 'assets/images/croissant.png',
        duration: '15 mins',
        calorie: '100 kcal',
        price: '2.50',
        boxIsSelected: false,
      ),
    );
    popularList.add(
      PopularModel(
        name: 'cat_noodle',
        iconPath: 'assets/images/noodles.png',
        duration: '5 mins',
        calorie: '80 kcal',
        price: '5.00',
        boxIsSelected: false,
      ),
    );
    return popularList;
  }
}
