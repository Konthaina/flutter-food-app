import 'package:flutter/material.dart';
import '../models/diet_model.dart';

class CartProvider extends ChangeNotifier {
  final List<DietModel> _items = [];
  final List<DietModel> _favorites = [];

  List<DietModel> get items => _items;
  List<DietModel> get favorites => _favorites;

  // Cart Methods
  void addItem(DietModel item) {
    bool exists = _items.any((element) => element.name == item.name);
    if (!exists) {
      _items.add(item);
      notifyListeners();
    }
  }

  void removeItem(DietModel item) {
    _items.removeWhere((element) => element.name == item.name);
    notifyListeners();
  }

  void toggleItem(DietModel item) {
    bool exists = _items.any((element) => element.name == item.name);
    if (exists) {
      _items.removeWhere((element) => element.name == item.name);
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  bool isInCart(String name) {
    return _items.any((element) => element.name == name);
  }

  // Favorite Methods
  void toggleFavorite(DietModel item) {
    bool exists = _favorites.any((element) => element.name == item.name);
    if (exists) {
      _favorites.removeWhere((element) => element.name == item.name);
    } else {
      _favorites.add(item);
    }
    notifyListeners();
  }

  bool isFavorite(String name) {
    return _favorites.any((element) => element.name == name);
  }

  double get total => _items.fold(0, (sum, item) => sum + double.parse(item.price));
}
