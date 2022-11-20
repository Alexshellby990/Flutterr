import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  /// Default theme
  ThemeMode themeMode = ThemeMode.light;

  @override
  void onInit() {
    var storedThemeModeString = GetStorage().read('themeMode');
    ThemeMode? storedThemeMode;


    if (storedThemeModeString == ThemeMode.system.toString()) {
      storedThemeMode = ThemeMode.system;
    } else if (storedThemeModeString == ThemeMode.light.toString()) {
      storedThemeMode = ThemeMode.light;
    } else if (storedThemeModeString == ThemeMode.dark.toString()) {
      storedThemeMode = ThemeMode.dark;
    }

    if (storedThemeModeString != null) {
      /// Take from database if theme mode already exists in database
      themeMode = storedThemeMode!;
    } else {
      /// Set default theme and save to database if theme mode doesn't exist in database
      saveToDatabase('themeMode', themeMode.toString());
    }

    super.onInit();
  }

  void toggleTheme() {
    themeMode = Get.isDarkMode ? ThemeMode.light : ThemeMode.dark;

    /// Update the UI
    update();

    /// Save to database
    saveToDatabase('themeMode', themeMode.toString());
  }

  void saveToDatabase(String key, dynamic value) {
    GetStorage().write(key, value);
  }
}