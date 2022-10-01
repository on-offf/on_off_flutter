enum IconPath {

  // appbar
  appbarPreviousButton,
  setting,

  // calendar
  nextMonthButton,
  previousMonthButton,

  // floating_button
  floatingActionButtonOnOff,
  floatingActionButtonMonthlyWeekly,

  // off_write
  calendarAdd,
  camera,
  clip,
  trashCan,

  // stickers
  expressionAngry,
  expressionLittleSad,
  expressionNormal,
  expressionSleep,
  expressionSmallEye,
  expressionSmile,
  note,
  rice,
  star,
  weatherSnow,
  weatherSunny,
  wineGlass,

  // etc
  plus,
  minus,
  downArrow,
}

extension IconExtension on IconPath {
  String get name {
    switch (this) {
      case IconPath.appbarPreviousButton:
        return "assets/icons/appbar/appbar_previous_button.png";
      case IconPath.setting:
        return "assets/icons/appbar/setting.png";

      case IconPath.nextMonthButton:
        return "assets/icons/calendar/next_month_button.png";
      case IconPath.previousMonthButton:
        return "assets/icons/calendar/previous_month_button.png";

      case IconPath.floatingActionButtonOnOff:
        return "assets/icons/floating_button/floating_action_button_on_off.png";
      case IconPath.floatingActionButtonMonthlyWeekly:
        return "assets/icons/floating_button/floating_action_button_monthly_weekly.png";

      case IconPath.calendarAdd:
        return "assets/icons/off_write/calendar_add.png";
      case IconPath.camera:
        return "assets/icons/off_write/camera.png";
      case IconPath.clip:
        return "assets/icons/off_write/clip.png";
      case IconPath.trashCan:
        return "assets/icons/off_write/trash_can.png";

      case IconPath.expressionNormal:
        return "assets/icons/stickers/expression_normal.png";
      case IconPath.expressionSmile:
        return "assets/icons/stickers/expression_smile.png";
      case IconPath.expressionLittleSad:
        return "assets/icons/stickers/expression_little_sad.png";
      case IconPath.expressionSleep:
        return "assets/icons/stickers/expression_sleep.png";
      case IconPath.expressionAngry:
        return "assets/icons/stickers/expression_angry.png";
      case IconPath.expressionSmallEye:
        return "assets/icons/stickers/expression_small_eye.png";
      case IconPath.wineGlass:
        return "assets/icons/stickers/wine_glass.png";
      case IconPath.star:
        return "assets/icons/stickers/star.png";
      case IconPath.rice:
        return "assets/icons/stickers/rice.png";
      case IconPath.note:
        return "assets/icons/stickers/note.png";
      case IconPath.weatherSnow:
        return "assets/icons/stickers/weather_snow.png";
      case IconPath.weatherSunny:
        return "assets/icons/stickers/weather_sunny.png";

      case IconPath.downArrow:
        return "assets/icons/down_arrow.png ";
      case IconPath.plus:
        return "assets/icons/plus.png";
      case IconPath.minus:
        return "assets/icons/minus.png";

      default:
        return "";
    }
  }
}
