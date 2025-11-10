import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/context_extension.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/providers/category_switch.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategorySwitch>(context);
    return InkWell(
      onTap: () {
        provider.updateSelectedCategory(categoryModel);
      },
      child: AspectRatio(
        aspectRatio: 363 / 198,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                context.provider.isDark(context)
                    ? categoryModel.lightImagePath
                    : categoryModel.darkImagePath,
              ),
            ),
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              crossAxisAlignment:
                  categoryModel.rtl
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    context.provider.appLocal == 'en'
                        ? categoryModel.enName
                        : categoryModel.arName,
                    style: context.text.headlineLarge!.copyWith(
                      color: context.colors.onPrimary,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    color: context.colors.secondary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    spacing: 16,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        context.local.view,
                        style: context.text.bodyLarge!.copyWith(
                          color:
                              context.provider.isDark(context)
                                  ? context.colors.primary
                                  : context.colors.onPrimary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              context.provider.isDark(context)
                                  ? context.colors.onPrimary
                                  : context.colors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          color:
                              context.provider.isDark(context)
                                  ? context.colors.primary
                                  : context.colors.onPrimary,
                          categoryModel.rtl
                              ? Icons.arrow_forward
                              : Icons.arrow_back,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
