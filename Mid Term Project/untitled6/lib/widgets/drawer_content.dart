import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tasbih_settings_controller.dart';
import 'change_theme_button.dart';

class DrawerContent extends StatelessWidget {
  final tasbihSettingsController = Get.find<TasbihSettingsController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: Text('Menu List'),
          ),

          /// Theme mode
          ListTile(
            leading: Icon(Icons.dark_mode_outlined),
            title: Text('Mode Dark'),
            trailing: ChangeThemeButton(),
          ),

          /// Only show on mobile platform
          if (GetPlatform.isMobile && !GetPlatform.isWeb) ...[
            /// Long vibration each 33
            ListTile(
              leading: Icon(Icons.vibration_outlined),
              title: Text('Long shakes in multiples of 33'),
              trailing: GetBuilder<TasbihSettingsController>(
                builder: (context) {
                  return Switch.adaptive(
                    value: tasbihSettingsController.longVibrateEach33,
                    onChanged: (_) {
                      tasbihSettingsController.toggleLongVibrateEach33();
                    },
                  );
                },
              ),
            ),

            /// Long vibration each 100
            ListTile(
              leading: Icon(Icons.vibration_outlined),
              title: Text('Long shakes in multiples of 100'),
              trailing:
                  GetBuilder<TasbihSettingsController>(builder: (context) {
                return Switch.adaptive(
                  value: tasbihSettingsController.longVibrateEach100,
                  onChanged: (value) {
                    tasbihSettingsController.toggleLongVibrateEach100();
                  },
                );
              }),
            ),
          ],

          Spacer(),

          /// App version
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Center(child: Text('Version 2.2.25')),
          ),
        ],
      ),
    );
  }
}