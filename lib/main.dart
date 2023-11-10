import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:scalpinspector_app/db_helper.dart';
import 'package:scalpinspector_app/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().initDatabase();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScalpInspectorApp());
  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     tools: [
  //       ...DevicePreview.defaultTools,
  //     ],
  //     builder: (context) => ScalpInspectorApp(), // Wrap your app
  //   ),
  // );
}

class ScalpInspectorApp extends StatelessWidget {
  const ScalpInspectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Scalp Inspector',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
