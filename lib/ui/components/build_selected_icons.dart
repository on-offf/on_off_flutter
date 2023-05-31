import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_off/ui/provider/ui_provider.dart';

//off 화면에서
Widget buildSelectedIcon(String iconPath, UiProvider uiProvider) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: SvgPicture.asset(
      iconPath,
      width: 14,
      height: 14,
      colorFilter: ColorFilter.mode(
        uiProvider.state.colorConst.getPrimary(),
        BlendMode.srcIn,
      ),
    ),
  );
}
