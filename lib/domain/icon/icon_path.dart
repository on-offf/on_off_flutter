enum IconPath {
  // appbar
  appbarPreviousButton,
  setting,

  // calendar
  nextYearButton,
  previousYearButton,

  // floating_button
  floatingActionButtonOnOff,
  floatingActionButtonChange,
  floatingActionButtonMonthlyWeekly,

  // off_write
  calendarAdd,
  camera,
  clip,
  trashCan,
  noHaveContent,

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

  // on_main
  todoSubmit,

  // setting
  settingArrowButton,

  // etc
  plus,
  minus,
  downArrow,
  submit,
  menu,
}

extension IconExtension on IconPath {
  String get name {
    switch (this) {
      case IconPath.appbarPreviousButton:
        return "assets/icons/appbar/appbar_previous_button.svg";
      case IconPath.setting:
        return "assets/icons/appbar/setting.svg";

      case IconPath.nextYearButton:
        return "assets/icons/calendar/next_year_button.svg";
      case IconPath.previousYearButton:
        return "assets/icons/calendar/previous_year_button.svg";

      case IconPath.floatingActionButtonChange:
        return "assets/icons/floating_button/floating_action_button_change.svg";
      case IconPath.floatingActionButtonOnOff:
        return "assets/icons/floating_button/floating_action_button_on_off.svg";
      case IconPath.floatingActionButtonMonthlyWeekly:
        return "assets/icons/floating_button/floating_action_button_monthly_weekly.svg";

      case IconPath.calendarAdd:
        return "assets/icons/off_write/calendar_add.svg";
      case IconPath.camera:
        return "assets/icons/off_write/camera.svg";
      case IconPath.clip:
        return "assets/icons/off_write/clip.svg";
      case IconPath.trashCan:
        return "assets/icons/off_write/trash_can.svg";
      case IconPath.noHaveContent:
        return "assets/icons/off_write/no_have_content.svg";

      case IconPath.expressionNormal:
        return "assets/icons/stickers/expression_normal.svg";
      case IconPath.expressionSmile:
        return "assets/icons/stickers/expression_smile.svg";
      case IconPath.expressionLittleSad:
        return "assets/icons/stickers/expression_little_sad.svg";
      case IconPath.expressionSmileEye:
        return "assets/icons/stickers/expression_smile_eye.svg";
      case IconPath.expressionAngry:
        return "assets/icons/stickers/expression_angry.svg";
      case IconPath.expressionSmallEye:
        return "assets/icons/stickers/expression_small_eye.svg";
      case IconPath.expressionCry:
        return "assets/icons/stickers/expression_cry.svg";
      case IconPath.expressionLine:
        return "assets/icons/stickers/expression_line.svg";
      case IconPath.expressionPairOfEye:
        return "assets/icons/stickers/expression_pair_of_eye.svg";
      case IconPath.expressionReverse:
        return "assets/icons/stickers/expression_reverse.svg";
      case IconPath.expressionSleep:
        return "assets/icons/stickers/expression_sleep.svg";

      case IconPath.todoSubmit:
        return "assets/icons/on/todo_submit.svg";

      case IconPath.settingArrowButton:
        return "assets/icons/setting/setting_arrow_button.svg";

      case IconPath.downArrow:
        return "assets/icons/down_arrow.svg";
      case IconPath.plus:
        return "assets/icons/plus.svg";
      case IconPath.minus:
        return "assets/icons/minus.svg";
      case IconPath.submit:
        return "assets/icons/submit.svg";
      case IconPath.menu:
        return "assets/icons/menu.svg";

      default:
        return "";
    }
  }
}
