import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> mySnackBar({
  required BuildContext context,
  required bool success,
  required String successfulText,
  required String unsuccessfulText,
}) {
  MaterialColor bkgrColor;

  if (success) {
    bkgrColor = Colors.green;
  } else {
    bkgrColor = Colors.red;
  }

  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            success ? Icons.check_circle_outline_rounded : Icons.info_outline,
            size: 30,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            success ? successfulText : unsuccessfulText,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      backgroundColor: bkgrColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
  );
}
