import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';

import 'controllers/tasbih_controller.dart';
import 'controllers/tasbih_settings_controller.dart';
import 'controllers/theme_controller.dart';
import 'models/theme_model.dart';
import 'screens/counter_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Remove hash (#) from url
  setPathUrlStrategy();

  /// Initialize storage
  await GetStorage.init();

  /// For theming
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final tasbihController = Get.lazyPut(() => TasbihController());
  final tasbihSettingsController =
  Get.lazyPut(() => TasbihSettingsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (context) {
        return GetMaterialApp(
          key: UniqueKey(),
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => HomeScreen()),
            GetPage(
              name: '/counter',
              page: () => CounterScreen(),
              transition: Transition.cupertino,
            ),
          ],
          title: ' Tasbeeh Digital(Mid Project) ',
          themeMode: themeController.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
        );
      },
    );
  }
}