import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/context_extension.dart';
import 'package:news_app/core/extensions/padding_extension.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/ui/home/widgets/category_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.local.morning,
          style: context.text.titleLarge,
        ).symmetricPadding(horizontal: 16),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryCard(categoryModel: categories[index]);
            },
          ),
        ),
      ],
    );
  }
}
