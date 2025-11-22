import 'package:flutter/widgets.dart';

class SearchProvider extends ChangeNotifier {
  String search = '';
  TextEditingController input = TextEditingController();
  List results = [];
  getSearchResult(String value) {
    search = value;
    notifyListeners();
  }
}
