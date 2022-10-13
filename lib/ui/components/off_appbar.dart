import 'package:flutter/material.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/components/simple_dialog.dart';
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
                      uiState.colorConst.canvas,
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
  BuildContext context,
  String password,
  Color primaryColor,
  Color canvasColor,
) async {
  var result =
      await Navigator.pushNamed(context, PasswordConfirmScreen.routeName);

  if (result == null) {
    /* do nothing */
  } else if (result == password) {
    Navigator.pushNamed(context, SettingScreen.routeName);
  } else {
    simpleTextDialog(
      context,
      primaryColor: primaryColor,
      canvasColor: canvasColor,
      message: '비밀번호가 일치하지 않습니다.',
    );
  }
}
