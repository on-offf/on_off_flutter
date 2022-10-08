enum IconPath {

  // appbar
  appbarPreviousButton,
  setting,

  // calendar
  nextYearButton,
  previousYearButton,

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
  expressionSmileEye,
  expressionSmallEye,
  expressionSmile,
  expressionCry,
  expressionLine,
  expressionPairOfEye,
  expressionReverse,
  expressionSleep,

  // etc
  plus,
  minus,
  downArrow,
  submit,
}

extension IconExtension on IconPath {
  String get name {
    switch (this) {
      case IconPath.appbarPreviousButton:
        return "assets/icons/appbar/appbar_previous_button.png";
      case IconPath.setting:
        return "assets/icons/appbar/setting.png";

      case IconPath.nextYearButton:
        return "assets/icons/calendar/next_year_button.png";
      case IconPath.previousYearButton:
        return "assets/icons/calendar/previous_year_button.png";

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
      case IconPath.expressionSmileEye:
        return "assets/icons/stickers/expression_smile_eye.png";
      case IconPath.expressionAngry:
        return "assets/icons/stickers/expression_angry.png";
      case IconPath.expressionSmallEye:
        return "assets/icons/stickers/expression_small_eye.png";
      case IconPath.expressionCry:
        return "assets/icons/stickers/expression_cry.png";
      case IconPath.expressionLine:
        return "assets/icons/stickers/expression_line.png";
      case IconPath.expressionPairOfEye:
        return "assets/icons/stickers/expression_pair_of_eye.png";
      case IconPath.expressionReverse:
        return "assets/icons/stickers/expression_reverse.png";
      case IconPath.expressionSleep:
        return "assets/icons/stickers/expression_sleep.png";

      case IconPath.downArrow:
        return "assets/icons/down_arrow.png";
      case IconPath.plus:
        return "assets/icons/plus.png";
      case IconPath.minus:
        return "assets/icons/minus.png";
      case IconPath.submit:
        return "assets/icons/submit.png";

      default:
        return "";
    }
  }
}
