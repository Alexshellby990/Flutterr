import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import '../controllers/tasbih_controller.dart';
import 'text_editing_dialog.dart';

class TasbihList extends StatelessWidget {
  final tasbihController = Get.find<TasbihController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        padding: EdgeInsets.only(bottom: 30),
        itemCount: tasbihController.tasbihs.length,
        separatorBuilder: (context, index) => SizedBox(height: 15),
        itemBuilder: (context, index) {
          return SwipeActionCell(
            key: UniqueKey(),
            backgroundColor: Colors.transparent,
            deleteAnimationDuration: 400,
            trailingActions: <SwipeAction>[
              SwipeAction(
                icon: Icon(Icons.edit),
                color: Colors.transparent,
                onTap: (CompletionHandler handler) async {
                  /// Show dialog
                  TextEditingDialog.showTextEditingDialog(
                    context: context,
                    indexToEdit: index, // Should not be a String
                  );

                  /// Move the list tile back to original position
                  handler(false);
                },
              ),
              SwipeAction(
                icon: Icon(Icons.delete),
                color: Colors.transparent,
                onTap: (CompletionHandler handler) async {
                  /// Vibrate
                  HapticFeedback.mediumImpact();

                  /// Remove item from ListView
                  await handler(true);

                  /// Remove data from database
                  _removeItem(index);
                },
              ),
            ],
            child:
                // ListTile
                _buildItem(tasbihController.tasbihs[index], index),
          );
        },
      ),
    );
  }

  Widget _buildItem(var item, int index) {
    /// Formatting the date
    DateTime originalUpdatedAt =
        DateTime.parse(tasbihController.tasbihs[index].updatedAt);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formattedUpdatedAt = formatter.format(originalUpdatedAt);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: Get.theme.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: ListTile(
        title: Text(
          tasbihController.tasbihs[index].name,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          tasbihController.tasbihs[index].updatedAt == '1970-01-01 00:00:00'
              ? 'Never been used(کبھی استعمال نہیں ہوا)'
              : 'Used on (پر استعمال کیا جاتا ہے) $formattedUpdatedAt',
        ),
        trailing: Container(
          height: 35,
          width: 35, // It shows max of 3 digits number
          padding: EdgeInsets.all(2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Get.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Text(
            '${tasbihController.tasbihs[index].count}',
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        onTap: () {
          Get.toNamed('/counter?index=' + index.toString());
        },
        onLongPress: () {
          Fluttertoast.showToast(
            msg: "Swipe left for more options",
            toastLength: Toast.LENGTH_LONG,
            webPosition: 'center',
            webBgColor: '#000',
            timeInSecForIosWeb: 3,
          );
        },
      ),
    );
  }

  void _removeItem(int index) {
    var removed = tasbihController.tasbihs[index];

    /// Remove data from database
    tasbihController.remove(index);

    Get.snackbar(
      '${removed.name} deleted',
      'Press Undo to restore.',
      boxShadows: [
        BoxShadow(
          offset: Offset(0, 3),
          blurRadius: 20,
          color: Colors.black26,
        ),
      ],
      mainButton: TextButton(
        child: Text(
          'undo',
        ),
        onPressed: () {
          if (removed == null) {
            return;
          }


          tasbihController.tasbihs.insert(index, removed);

          removed = null;
          if (Get.isSnackbarOpen!) {
            Get.back();
          }
        },
      ),
    );
  }
}