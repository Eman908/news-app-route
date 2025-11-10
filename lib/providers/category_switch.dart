import 'package:flutter/widgets.dart';
import 'package:news_app/models/category_model.dart';

class CategorySwitch extends ChangeNotifier {
  CategoryModel? selectedCategory;
  updateSelectedCategory(CategoryModel category) {
    selectedCategory = category;
    notifyListeners();
  }
}
