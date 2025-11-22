import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/core/providers/theme_and_local_provider.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/run_app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final provider = ThemeAndLocalProvider();
  await provider.loadPreferences();
  await dotenv.load(fileName: ".env");

  runApp(ChangeNotifierProvider.value(value: provider, child: const NewsApp()));
}
