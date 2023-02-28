import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

//off 화면에서
Widget buildSelectedIcon(String iconPath) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: SvgPicture.asset(
      iconPath,
      width: 14,
      height: 14,
    ),
  );
}
