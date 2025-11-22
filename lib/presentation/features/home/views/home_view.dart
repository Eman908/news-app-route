import 'package:flutter/material.dart';
import 'package:news_app/core/base/base_view.dart';
import 'package:news_app/core/extensions/context_extension.dart';
import 'package:news_app/core/utils/app_assets.dart';
import 'package:news_app/core/utils/app_routes.dart';
import 'package:news_app/presentation/features/home/view_model/home_navigator.dart';
import '../view_model/category_switch.dart';
import 'tabs/home_tab.dart';
import 'tabs/news_tab.dart';
import 'widgets/home_drawer.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseView<HomeView, CategorySwitch>
    implements HomeNavigator {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CategorySwitch(),
      builder: (context, child) {
        final provider = Provider.of<CategorySwitch>(context);
        return Scaffold(
          drawer: HomeDrawer(
            goToHome: () {
              push(AppRoutes.homeRoute);
            },
          ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              provider.selectedCategory == null
                  ? context.local.home
                  : context.provider.appLocal == 'en'
                  ? provider.selectedCategory!.enName
                  : provider.selectedCategory!.arName,
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  push(AppRoutes.searchRoute);
                },
                icon: const ImageIcon(AssetImage(Assets.assetsImagesSearch)),
              ),
            ],
          ),
          body:
              provider.selectedCategory == null
                  ? const HomeTab()
                  : NewsTab(categoryModel: provider.selectedCategory!),
        );
      },
    );
  }

  @override
  CategorySwitch getViewModel() {
    return CategorySwitch();
  }

  @override
  void push(String route) {
    Navigator.pushReplacementNamed(context, route);
  }
}
