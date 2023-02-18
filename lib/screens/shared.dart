import 'package:flutter/material.dart';

import '../core/colors.dart';

showSnakBarSuccess(BuildContext context,String message ,Color color) {
    final snackBar = SnackBar(
      backgroundColor: color,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style:Theme.of(context).textTheme.headline2,
          ),
        ],
      ),
      action: SnackBarAction(
        textColor: whiteColor,
        label: 'ok',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showLoading(BuildContext context, String message,
      {bool isCancellable = true}) {
    return showDialog(
      context: context,
      barrierDismissible: isCancellable,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Text(message),
              const SizedBox(
                width: 15,
              ),
              const CircularProgressIndicator()
            ],
          ),
        );
      },
    );
  }

  hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }