import 'package:flutter/material.dart';

showSnackBar(String text, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.redAccent,
    duration: const Duration(milliseconds: 3000),
    // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height - 200),
  ));
}
