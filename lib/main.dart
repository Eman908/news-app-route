import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/providers/theme_and_local_provider.dart';
import 'package:news_app/run_app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final provider = ThemeAndLocalProvider();
  await provider.loadPreferences();
  await dotenv.load(fileName: ".env");

  runApp(ChangeNotifierProvider.value(value: provider, child: const NewsApp()));
}
