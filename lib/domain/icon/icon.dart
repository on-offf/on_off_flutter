enum IconPath {
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

extension IconExtension on IconPath {
  String get name {
    switch (this) {
      case IconPath.plus:
        return "assets/icons/plus.png";
      case IconPath.minus:
        return "assets/icons/minus.png";
      case IconPath.expressionNormal:
        return "assets/icons/expression_normal.png";
      case IconPath.expressionSmile:
        return "assets/icons/expression_smile.png";
      case IconPath.expressionLittleSad:
        return "assets/icons/expression_little_sad.png";
      case IconPath.expressionSleep:
        return "assets/icons/expression_sleep.png";
      case IconPath.expressionAngry:
        return "assets/icons/expression_angry.png";
      case IconPath.expressionSmallEye:
        return "assets/icons/expression_small_eye.png";
      case IconPath.wineGlass:
        return "assets/icons/wine_glass.png";
      case IconPath.star:
        return "assets/icons/star.png";
      case IconPath.rice:
        return "assets/icons/rice.png";
      case IconPath.note:
        return "assets/icons/note.png";
      case IconPath.weatherSnow:
        return "assets/icons/weather_snow.png";
      case IconPath.weatherSunny:
        return "assets/icons/weather_sunny.png";
      case IconPath.changeCategory:
        return "assets/icons/change_category.png";
      case IconPath.downArrow:
        return "assets/icons/down_arrow.png ";
      case IconPath.setting:
        return "assets/icons/setting.png";
      default:
        return "";
    }
  }
}
