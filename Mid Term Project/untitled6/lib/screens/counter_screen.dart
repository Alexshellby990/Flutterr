import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../controllers/tasbih_controller.dart';
import '../widgets/counter.dart';

class CounterScreen extends StatelessWidget {
  final tasbihController = Get.find<TasbihController>();

  final index = int.parse(Get.parameters['index']!);

  final double maxScreenWidth = 768;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            alignment: Alignment.center,
            width: maxScreenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Toolbar
                Container(
                  padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tasbihController.tasbihs[index].name,
                        style: const TextStyle(fontSize: 30),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// Counter section
                Expanded(
                  child: Counter(index: index),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}