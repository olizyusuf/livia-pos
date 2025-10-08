import 'package:flutter/material.dart';

class AlertdialogHelper {
  static void showSimpleAlertDialog(
    BuildContext context, {
    String? title,
    required String message,
    String btnText = 'OK',
    VoidCallback? onPressed,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          titleTextStyle: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                  if (onPressed != null) {
                    onPressed(); // Panggil callback jika ada
                  }
                },
                child: Text(btnText))
          ],
        );
      },
    );
  }
}
