import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'constants/color_manger.dart';
import 'constants/style_manager.dart';

class Utils {
  static String formatDateTime(DateTime date) {
    final DateFormat formatter = DateFormat(
      'yyyy-MM-dd',
    ); // Customize your format here
    return formatter.format(date);
  }

  static Future<bool> isOnline() async {
    try {
      final result = await Connectivity().checkConnectivity();
      if (result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.ethernet)) {
        return true;
      } else {
        alertOfflineActivity();
        return false;
      }
    } on PlatformException catch (e) {
      throw Exception('Could not check connectivity status: $e');
    }
  }

  static void alertOfflineActivity() {
    Fluttertoast.showToast(
      msg: "Please connect to internet",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  static Future<bool?> showErrorToast({required String message}) {
    return Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  static void showToast({
    required String message,
    required Color backgroundColor,
    required Color textColor,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }

  bool isTablet(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      return true;
    } else {
      return false;
    }
  }

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  ///,*****************  selectDate  ************************
  static Future<void> selectDate(
      BuildContext context,
      TextEditingController controller,
      ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorManager.brown,
              onPrimary: Colors.white,
            ),
            datePickerTheme: DatePickerThemeData(
              headerBackgroundColor: ColorManager.brown,
              headerForegroundColor: ColorManager.whiteColor,
              backgroundColor: ColorManager.backgroundSecondary,
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return ColorManager.brown;
                }
                return Colors.white;
              }),

              dayShape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              dayStyle:  getRegularStyle16_400(color: ColorManager.whiteColor),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorManager.brown,
                textStyle:  getRegularStyle16_400(color: ColorManager.brown),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('MMMM dd, yyyy').format(pickedDate);
      controller.text = formattedDate;
    }
  }
}
