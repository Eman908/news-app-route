import 'package:flutter/material.dart';
import 'package:news_app/core/base/base_navigator.dart';
import 'package:news_app/core/base/base_view_model.dart';

abstract class BaseView<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T>
    implements BaseNavigator {
  late VM viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = getViewModel();
    viewModel.navigator = this;
  }

  @override
  void dispose() {
    viewModel.navigator = null;
    super.dispose();
  }

  VM getViewModel();
}
