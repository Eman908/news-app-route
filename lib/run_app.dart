import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/context_extension.dart';
import 'package:news_app/core/utils/app_routes.dart';
import 'package:news_app/core/utils/app_theme.dart';
import 'package:news_app/l10n/generated/i18n/app_localizations.dart';
import 'package:news_app/presentation/features/home/views/home_view.dart';
import 'package:news_app/presentation/features/search/views/search_view.dart';
import 'package:news_app/presentation/features/splash/splash_view.dart';
import 'package:news_app/core/providers/theme_and_local_provider.dart';
import 'package:provider/provider.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeAndLocalProvider>(
      builder:
          (context, provider, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              AppRoutes.splashRoute: (context) => const SplashView(),
              AppRoutes.homeRoute: (context) => const HomeView(),
              AppRoutes.searchRoute: (context) => const SearchView(),
            },
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(context.provider.appLocal),
            theme: AppTheme.lightTheme,
            themeMode: context.provider.appTheme,
            darkTheme: AppTheme.darkTheme,
          ),
    );
  }
}
