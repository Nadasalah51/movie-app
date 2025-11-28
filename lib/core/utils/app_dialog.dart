import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_color.dart';

abstract class AppDialog {
  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            spacing: 10,
            children: [
              CircularProgressIndicator(color: AppColor.grayColor),
              Text(
                'loading..',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showError(BuildContext context, {required String error}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xff000000),
              fontWeight: FontWeight.w400,
            ),
          ),
          content: Text(
            error,
            style: TextStyle(
              fontSize: 20,
              color: Color(0xff000000),
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ok'),
            ),
          ],
        ),
      ),
    );
  }
}
