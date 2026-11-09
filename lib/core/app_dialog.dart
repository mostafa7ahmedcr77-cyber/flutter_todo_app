import 'package:flutter/material.dart';

abstract class AppDialog {
  static Future<void> showLoading(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            spacing: 20,
            children: [
              CircularProgressIndicator(),
              Text(
                "Loding...",
                style: TextStyle(fontSize: 16, fontWeight: .w400),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showError(BuildContext context, String error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Error',
            style: TextStyle(
              fontSize: 20,
              fontWeight: .bold,
              color: Colors.red,
            ),
          ),
          content: Text(
            error,
            style: TextStyle(fontSize: 16, fontWeight: .bold),
          ),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
