import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class Guide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Get.theme.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Container(
            child: Image.asset(
              "assets/images/pilih_tasbih.png",
              height: 120,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Thanks for visiting my app. This is my mid term project. (Tasbih Counter App) ...',
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}