import 'dart:ui';

import 'package:flutter/material.dart';

abstract class ColorConst {
  Color secondaryLight = const Color(0xffFFB703);
  Color secondaryDark = const Color(0xffFB8501);

  Color black = const Color(0xff000000);
  Color darkGray = const Color(0xff4F4F4F);
  Color gray = const Color(0xffB3B3B3);
  Color lightGray = const Color(0xffE7E7E7);

  Color canvas = const Color(0xffebebeb);

  Color getPrimary();
  Color getPrimaryLight();
  Color getPrimaryDark();
  Color getPrimaryPlus();

  Color getSecondaryLight() {
    return secondaryLight;
  }

  Color getSecondaryDark() {
    return secondaryDark;
  }

  Color getBlack() {
    return black;
  }

  Color getDarkGray() {
    return darkGray;
  }

  Color getGray() {
    return gray;
  }

  Color getLightGray() {
    return lightGray;
  }
}

class OceanMainColor extends ColorConst {
  Color primary = const Color(0xff219EBC);
  Color primaryLight = const Color(0xff64CFEF);
  Color primaryDark = const Color(0xff065B83);
  Color primaryPlus = const Color(0xffF6FDFF);

  @override
  Color getPrimary() {
    return primary;
  }

  @override
  Color getPrimaryDark() {
    return primaryDark;
  }

  @override
  Color getPrimaryLight() {
    return primaryLight;
  }

  @override
  Color getPrimaryPlus() {
    return primaryPlus;
  }

}

class YellowMainColor extends ColorConst {
  Color primary = const Color(0xffFFE55A);
  Color primaryLight = const Color(0xffEFE4AD);
  Color primaryDark = const Color(0xffFFB703);

  // TODO 컬러 수정
  Color primaryPlus = const Color(0xff);

  @override
  Color getPrimary() {
    return primary;
  }

  @override
  Color getPrimaryDark() {
    return primaryDark;
  }

  @override
  Color getPrimaryLight() {
    return primaryLight;
  }

  @override
  Color getPrimaryPlus() {
    return primaryPlus;
  }
}

class PurpleMainColor extends ColorConst {
  Color primary = const Color(0xff9747FF);
  Color primaryLight = const Color(0xffD3B1FF);
  Color primaryDark = const Color(0xff6012C5);

  // TODO 컬러 수정
  Color primaryPlus = const Color(0xff);

  @override
  Color getPrimary() {
    return primary;
  }

  @override
  Color getPrimaryDark() {
    return primaryDark;
  }

  @override
  Color getPrimaryLight() {
    return primaryLight;
  }

  @override
  Color getPrimaryPlus() {
    return primaryPlus;
  }
}

class OrangeMainColor extends ColorConst {
  Color primary = const Color(0xffFB8501);
  Color primaryLight = const Color(0xffFFB703);
  Color primaryDark = const Color(0xffF4DEA7);

  // TODO 컬러 수정
  Color primaryPlus = const Color(0xff);

  @override
  Color getPrimary() {
    return primary;
  }

  @override
  Color getPrimaryDark() {
    return primaryDark;
  }

  @override
  Color getPrimaryLight() {
    return primaryLight;
  }

  @override
  Color getPrimaryPlus() {
    return primaryPlus;
  }
}

