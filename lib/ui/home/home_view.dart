import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/context_extension.dart';
import 'package:news_app/core/utils/app_assets.dart';
import 'package:news_app/core/utils/app_routes.dart';
import 'package:news_app/providers/category_switch.dart';
import 'package:news_app/ui/home/tabs/home_tab.dart';
import 'package:news_app/ui/home/tabs/news_tab.dart';
import 'package:news_app/ui/home/widgets/home_drawer.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CategorySwitch(),
      builder: (context, child) {
        final provider = Provider.of<CategorySwitch>(context);
        return Scaffold(
          drawer: const HomeDrawer(),
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
                  Navigator.pushNamed(context, AppRoutes.searchRoute);
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
}
