import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../controllers/theme_controller.dart';
import '../widgets/drawer_content.dart';
import '../widgets/guide.dart';
import '../widgets/tasbih_list.dart';
import '../widgets/text_editing_dialog.dart';

class HomeScreen extends StatelessWidget {
  final themeController = Get.find<ThemeController>();

  final double maxScreenWidth = 768;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: DrawerContent()),
      body: SafeArea(
        child: Center(
          child: Container(
            width: maxScreenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Toolbar
                Container(
                  padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Builder(builder: (context) {
                            return IconButton(
                              icon: Icon(Icons.menu),
                              padding: EdgeInsets.zero,
                              tooltip: 'Menu List',
                              onPressed: () {
                                // Open drawer
                                Scaffold.of(context).openDrawer();
                              },
                            );
                          }),
                          Text('Tasbhee App By Mubashar Mumtaz (SP18-BCS-091)'),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add,
                        ),
                        padding: EdgeInsets.zero,
                        tooltip: 'Add Tasbheeh Name',
                        onPressed: () {
                          // Show dialog
                          TextEditingDialog.showTextEditingDialog(
                              context: context);
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                /// List of tasbih
                Expanded(
                  child: TasbihList(),
                ),

                /// Guide
                /// Show only when touch keyboard is closed
                if (MediaQuery.of(context).viewInsets.bottom == 0)
                  GetBuilder<ThemeController>(builder: (_) => Guide()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}