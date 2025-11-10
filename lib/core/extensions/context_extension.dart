import 'package:flutter/material.dart';
import 'package:news_app/l10n/generated/i18n/app_localizations.dart';
import 'package:news_app/providers/theme_and_local_provider.dart';
import 'package:provider/provider.dart';

extension ContextExtension on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  AppLocalizations get local => AppLocalizations.of(this)!;
  ThemeAndLocalProvider get provider =>
      Provider.of<ThemeAndLocalProvider>(this, listen: false);
}
