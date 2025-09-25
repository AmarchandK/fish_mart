// import 'package:firebase_core/firebase_core.dart'; // Temporarily commented out
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'core/di/injection_container.dart' as di;
import 'presentation/app/fish_mart_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await di.init();

  // Initialize Firebase - temporarily commented out
  // await Firebase.initializeApp();

  // Initialize Hive
  await Hive.initFlutter();

  runApp(const FishMartApp());
}
