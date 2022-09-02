enum Icon {
  plus,
  minus,
  expressionNormal,
  expressionSmile,
  expressionLittleSad,
  expressionSleep,
  expressionAngry,
  expressionSmallEye,
  wineGlass,
  star,
  rice,
  note,
  weatherSnow,
  weatherSunny,
  changeCategory,
  downArrow,
  setting,
}

extension IconExtension on Icon {
  String get name {
    switch (this) {
      case Icon.plus:
        return "assets/icons/plus.png";
      case Icon.minus:
        return "assets/icons/minus.png";
      case Icon.expressionNormal:
        return "assets/icons/expression_normal.png";
      case Icon.expressionSmile:
        return "assets/icons/expression_smile.png";
      case Icon.expressionLittleSad:
        return "assets/icons/expression_little_sad.png";
      case Icon.expressionSleep:
        return "assets/icons/expression_sleep.png";
      case Icon.expressionAngry:
        return "assets/icons/expression_angry.png";
      case Icon.expressionSmallEye:
        return "assets/icons/expression_small_eye.png";
      case Icon.wineGlass:
        return "assets/icons/wine_glass.png";
      case Icon.star:
        return "assets/icons/star.png";
      case Icon.rice:
        return "assets/icons/rice.png";
      case Icon.note:
        return "assets/icons/note.png";
      case Icon.weatherSnow:
        return "assets/icons/weather_snow.png";
      case Icon.weatherSunny:
        return "assets/icons/weather_sunny.png";
      case Icon.changeCategory:
        return "assets/icons/change_category.png";
      case Icon.downArrow:
        return "assets/icons/down_arrow.png ";
      case Icon.setting:
        return "assets/icons/setting.png";
      default:
        return "";
    }
  }
}
