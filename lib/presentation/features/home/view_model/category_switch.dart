import 'package:news_app/core/base/base_view_model.dart';
import 'package:news_app/data/models/categories_model/category_model.dart';
import 'package:news_app/presentation/features/home/view_model/home_navigator.dart';

class CategorySwitch extends BaseViewModel<HomeNavigator> {
  CategoryModel? selectedCategory;
  updateSelectedCategory(CategoryModel category) {
    selectedCategory = category;
    notifyListeners();
  }

  pushNavigatorRoute(String route) {
    navigator?.push(route);
    notifyListeners();
  }
}
