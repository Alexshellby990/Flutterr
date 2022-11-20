import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../models/tasbih_model.dart';

class TasbihController extends GetxController {
  var tasbihs = [].obs;

  @override
  void onInit() {
    List? storedTasbihs = GetStorage().read<List>('tasbeehs');

    if (storedTasbihs != null) {
      tasbihs = storedTasbihs.map((e) => Tasbih.fromJson(e)).toList().obs;
    } else {
      tasbihs.addAll([
        Tasbih(
          name: 'SubhanAllah',
          count: 0,
          updatedAt: '1970-01-01 00:00:00',
        ),
        Tasbih(
          name: 'AllahuAkbar',
          count: 0,
          updatedAt: '1970-01-01 00:00:00',
        ),
        Tasbih(
          name: 'MashAllah',
          count: 0,
          updatedAt: '1970-01-01 00:00:00',
        ),
      ]);
    }

    ever(tasbihs, (_) {
      GetStorage().write('tasbeehs', tasbihs.toList());
      super.onInit();
    });
  }

  void increment(index) {
    var increment = tasbihs[index];
    increment.count++;
    tasbihs[index] = increment;

    /// Update the updatedAt
    updateUpdatedAt(index);
  }

  void decrement(index) {
    var decrement = tasbihs[index];
    decrement.count--;
    tasbihs[index] = decrement;

    /// Update the updatedAt
    updateUpdatedAt(index);
  }

  void insert(name) {
    tasbihs.add(Tasbih(name: name));
  }

  void remove(index) {
    tasbihs.removeAt(index);
  }

  void rename(index, newName) {
    var rename = tasbihs[index];
    rename.name = newName;
    tasbihs[index] = rename;


  }

  void reset(index) {
    var reset = tasbihs[index];
    reset.count = 0;
    tasbihs[index] = reset;

    /// Update the updatedAt
    updateUpdatedAt(index);
  }

  void updateUpdatedAt(index) {
    var newUpdatedAt = tasbihs[index];
    newUpdatedAt.updatedAt = DateTime.now().toIso8601String();
    tasbihs[index] = newUpdatedAt;
  }

  bool isExist(name) {
    for (var i = 0; i < tasbihs.length; i++) {
      if (tasbihs[i].name == name) {
        return true;
      }
    }

    return false;
  }
}