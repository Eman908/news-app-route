import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/context_extension.dart';
import 'package:news_app/core/extensions/padding_extension.dart';
import 'package:news_app/core/utils/app_assets.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key, required this.goToHome});
  final void Function()? goToHome;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: context.screenHeight * .25,
            child: DrawerHeader(
              decoration: BoxDecoration(color: context.colors.primary),
              child: Center(
                child: Text(
                  context.local.newsapp,
                  style: context.text.titleLarge!.copyWith(
                    color: context.colors.onPrimary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: goToHome,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16,
              children: [
                const ImageIcon(AssetImage(Assets.assetsImagesHome1), size: 24),
                Text(context.local.gotohome, style: context.text.titleLarge),
              ],
            ),
          ),
          const Divider(),
          const SizedBox(height: 16),

          Row(
            spacing: 16,
            children: [
              const ImageIcon(
                AssetImage(Assets.assetsImagesRollerPaintBrush),
                size: 24,
              ),
              Text(context.local.theme, style: context.text.titleLarge),
            ],
          ).symmetricPadding(horizontal: 16),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              return DropdownMenu<ThemeMode>(
                initialSelection: context.provider.appTheme,
                width: constraints.maxWidth,
                onSelected: (value) {
                  context.provider.changeAppTheme(value!);
                },
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                menuStyle: MenuStyle(
                  fixedSize: WidgetStatePropertyAll(
                    Size(constraints.maxWidth, double.nan),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                dropdownMenuEntries: [
                  DropdownMenuEntry(
                    value: ThemeMode.dark,
                    label: context.local.dark,
                  ),
                  DropdownMenuEntry(
                    value: ThemeMode.light,
                    label: context.local.light,
                  ),
                  DropdownMenuEntry(
                    value: ThemeMode.system,
                    label: context.local.system,
                  ),
                ],
              );
            },
          ).symmetricPadding(horizontal: 16),
          const SizedBox(height: 24),

          Row(
            spacing: 16,
            children: [
              const ImageIcon(
                AssetImage(Assets.assetsImagesGlobeAlt),
                size: 24,
              ),
              Text(context.local.language, style: context.text.titleLarge),
            ],
          ).symmetricPadding(horizontal: 16),
          const SizedBox(height: 16),

          LayoutBuilder(
            builder: (context, constraints) {
              return DropdownMenu<String>(
                initialSelection: context.provider.appLocal,
                width: constraints.maxWidth,
                onSelected: (value) {
                  context.provider.changeAppLocal(value!);
                },
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                menuStyle: MenuStyle(
                  fixedSize: WidgetStatePropertyAll(
                    Size(constraints.maxWidth, double.nan),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: 'en', label: context.local.english),
                  DropdownMenuEntry(value: 'ar', label: context.local.arabic),
                ],
              );
            },
          ).symmetricPadding(horizontal: 16),
        ],
      ),
    );
  }
}
