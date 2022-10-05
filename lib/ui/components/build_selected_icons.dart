import 'package:flutter/material.dart';

//off 화면에서
Image buildSelectedIcon(String iconPath) {
  return Image(
    image: AssetImage(iconPath),
    width: 14,
    height: 14,
  );
}
