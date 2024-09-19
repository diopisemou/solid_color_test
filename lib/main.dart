import 'package:flutter/material.dart';
import 'package:solid_color_test/app/solid_random_color_app.dart';
import 'package:solid_color_test/utils/extension/orientation_extension.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await OrientationExtension.lockVertical();
  runApp(const SolidRandomColorApp());
}

