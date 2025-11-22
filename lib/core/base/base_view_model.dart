import 'package:flutter/foundation.dart';
import 'package:news_app/core/base/base_navigator.dart';

class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier {
  N? navigator;
}
