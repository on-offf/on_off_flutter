import 'package:flutter/material.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/provider/ui_event.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/setting/home/setting_screen.dart';
import 'package:on_off/ui/setting/home/setting_view_model.dart';
import 'package:on_off/ui/setting/password/password_confirm_screen.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

PreferredSize offAppBar(
  BuildContext context, {
  required bool isPrevButton,
  bool settingButton = true,
}) {
  final uiProvider = context.watch<UiProvider>();
  final uiState = uiProvider.state;
  final settingViewModel = context.watch<SettingViewModel>();
  final settingState = settingViewModel.state;

  return PreferredSize(
    preferredSize: const Size.fromHeight(77),
    child: AppBar(
      toolbarHeight: 77,
      leading: isPrevButton
          ? ElevatedButton(
              onPressed: () {
                uiProvider.onEvent(
                    const UiEvent.changeFloatingActionButtonSwitch(true));
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  uiState.colorConst.canvas,
                ),
                elevation: MaterialStateProperty.all(0),
              ),
              child: Image(
                image: AssetImage(IconPath.appbarPreviousButton.name),
              ),
            )
          : Container(),
      actions: [
        settingButton
            ? GestureDetector(
                onTap: () async {
                  uiProvider.onEvent(
                      const UiEvent.changeCalendarFormat(CalendarFormat.month));

                  if (settingState.setting.password != null) {
                    _checkPassword(
                      context,
                      settingState.setting.password!,
                      uiState.colorConst.getPrimary(),
                    );
                  } else {
                    Navigator.pushNamed(context, SettingScreen.routeName);
                  }
                },
                child: Image(
                  image: AssetImage(IconPath.setting.name),
                  width: 24.17,
                  height: 24.76,
                ),
              )
            : Container(),
        const SizedBox(
          width: 40,
        ),
      ],
      elevation: 0.0,
      backgroundColor: uiState.colorConst.canvas,
    ),
  );
}

void _checkPassword(
    BuildContext context, String password, Color primaryColor) async {
  var result =
      await Navigator.pushNamed(context, PasswordConfirmScreen.routeName);

  if (result == password) {
    Navigator.pushNamed(context, SettingScreen.routeName);
  } else {
    _passwordWrongDialog(context, primaryColor);
  }
}

void _passwordWrongDialog(BuildContext context, Color primaryColor) {
  showDialog(
    barrierColor: Colors.transparent,
    context: context,
    builder: (_) => Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(35.0),
        ),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.0),
          border: Border.all(
            width: 1,
            color: primaryColor,
          ),
          color: Colors.white,
        ),
        child: const Align(
          alignment: Alignment.center,
          child: Text('비밀번호가 일치하지 않습니다.'),
        ),
      ),
    ),
  );
}
