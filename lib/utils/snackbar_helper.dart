// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, {required String message}) {
  final snacBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.red[400],
    showCloseIcon: true,
    closeIconColor: Colors.white,
    padding: EdgeInsets.all(10),
  );
  ScaffoldMessenger.of(context).showSnackBar(snacBar);
}

void showSuccessMessage(BuildContext context, {required String message}) {
  final snacBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.green[400],
    showCloseIcon: true,
    closeIconColor: Colors.white,
    padding: EdgeInsets.all(10),
  );
  ScaffoldMessenger.of(context).showSnackBar(snacBar);
}
