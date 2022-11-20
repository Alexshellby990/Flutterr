import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class TasbihSettingsController extends GetxController {
  bool longVibrateEach33 = false;
  bool longVibrateEach100 = false;

  @override
  void onInit() {
    bool? storedLongVibrateEach33 = GetStorage().read('longVibrateEach33');
    bool? storedLongVibrateEach100 = GetStorage().read('longVibrateEach100');

    if (storedLongVibrateEach33 != null) {
      longVibrateEach33 = storedLongVibrateEach33;
    }

    if (storedLongVibrateEach100 != null) {
      longVibrateEach100 = storedLongVibrateEach100;
    }

    super.onInit();
  }

  void toggleLongVibrateEach33() {
    longVibrateEach33 = !longVibrateEach33;

    /// Update the UI
    update();

    /// Save to database
    saveToDatabase('longVibrateEach33', longVibrateEach33);
  }

  void toggleLongVibrateEach100() {
    longVibrateEach100 = !longVibrateEach100;

    /// Update the UI
    update();

    /// Save to database
    saveToDatabase('longVibrateEach100', longVibrateEach100);
  }

  void saveToDatabase(String key, dynamic value) {
    GetStorage().write(key, value);
  }
}