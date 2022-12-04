import 'package:flutter/material.dart';

//off 화면에서
Widget buildSelectedIcon(String iconPath) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Image(
      image: AssetImage(iconPath),
      width: 14,
      height: 14,
    ),
  );
}
