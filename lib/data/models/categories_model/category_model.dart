import 'package:news_app/core/utils/app_assets.dart';

class CategoryModel {
  final String enName;
  final String arName;
  final String lightImagePath;
  final String darkImagePath;
  final String id;
  final bool rtl;

  CategoryModel({
    required this.id,
    required this.enName,
    required this.arName,
    required this.lightImagePath,
    required this.darkImagePath,
    required this.rtl,
  });
}

List<CategoryModel> categories = [
  CategoryModel(
    id: "general",
    enName: "General",
    arName: "عام",
    lightImagePath: Assets.assetsImagesGeneral,
    darkImagePath: Assets.assetsImagesGeneralDark,
    rtl: true,
  ),

  CategoryModel(
    id: "business",
    enName: "Business",
    arName: "الأعمال",
    lightImagePath: Assets.assetsImagesBusniess,
    darkImagePath: Assets.assetsImagesBusniessDark,
    rtl: false,
  ),
  CategoryModel(
    id: "sport",

    enName: "Sport",
    arName: "الرياضة",
    lightImagePath: Assets.assetsImagesSport,
    darkImagePath: Assets.assetsImagesSportDark,
    rtl: true,
  ),
  CategoryModel(
    id: "technology",

    enName: "Technology",
    arName: "التكنولوجيا",
    lightImagePath: Assets.assetsImagesTechnology,
    darkImagePath: Assets.assetsImagesTechnologyDark,
    rtl: false,
  ),

  CategoryModel(
    id: "entertainment",

    enName: "Entertainment",
    arName: "الترفيه",
    lightImagePath: Assets.assetsImagesEntertainment,
    darkImagePath: Assets.assetsImagesEntertainmentDark,
    rtl: true,
  ),
  CategoryModel(
    id: "health",

    enName: "Health",
    arName: "الصحة",
    lightImagePath: Assets.assetsImagesHelth,
    darkImagePath: Assets.assetsImagesHelthDark,
    rtl: false,
  ),
  CategoryModel(
    id: "science",

    enName: "Science",
    arName: "العلوم",
    lightImagePath: Assets.assetsImagesScience,
    darkImagePath: Assets.assetsImagesScienceDark,
    rtl: true,
  ),
];
