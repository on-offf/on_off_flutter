enum IconPath {
  appbarPreviousButton,
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
  calendarAdd,
  clip,
  trashCan,
  camera,
  floatingActionButtonOnOff,
  floatingActionButtonMonthlyWeekly,
}

extension IconExtension on IconPath {
  String get name {
    switch (this) {
      case IconPath.appbarPreviousButton:
        return "assets/icons/appbar_previous_button.png";
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
      case IconPath.calendarAdd:
        return "assets/icons/calendar_add.png";
      case IconPath.clip:
        return "assets/icons/clip.png";
      case IconPath.trashCan:
        return "assets/icons/trash_can.png";
      case IconPath.camera:
        return "assets/icons/camera.png";
      case IconPath.floatingActionButtonOnOff:
        return "assets/icons/floating_action_button_on_off.png";
      case IconPath.floatingActionButtonMonthlyWeekly:
        return "assets/icons/floating_action_button_monthly_weekly.png";
      default:
        return "";
    }
  }
}
