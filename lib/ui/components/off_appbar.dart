import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:on_off/domain/icon/icon_path.dart';
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
  final settingViewModel = context.watch<SettingViewModel>();

  return PreferredSize(
    preferredSize: const Size.fromHeight(77),
    child: AppBar(
      toolbarHeight: 77,
      leading: isPrevButton
          ? IconButton(
              onPressed: () {
                uiProvider.changeFloatingActionButtonSwitch(true);
                Navigator.pop(context);
              },
              // style: ButtonStyle(
              //   backgroundColor: MaterialStateProperty.all(
              //     uiProvider.state.colorConst.canvas,
              //   ),
              //   elevation: MaterialStateProperty.all(0),
              // ),
              icon: SvgPicture.asset(
                IconPath.appbarPreviousButton.name,
                color: uiProvider.state.colorConst.getPrimary(),
              ),
            )
          : Container(),
      actions: [
        settingButton
            ? GestureDetector(
                onTap: () async {
                  uiProvider.changeCalendarFormat(CalendarFormat.month);

                  if (settingViewModel.state.setting.isScreenLock == 1) {
                    _checkPassword(
                      context,
                      settingViewModel.state.setting.password,
                    );
                  } else {
                    Navigator.pushNamed(context, SettingScreen.routeName);
                  }
                },
                child: IconButton(
                  icon: SvgPicture.asset(
                    IconPath.setting.name,
                    width: 24.17,
                    height: 24.76,
                  ),
                  onPressed: () async {
                    uiProvider.changeCalendarFormat(CalendarFormat.month);

                    if (settingViewModel.state.setting.isScreenLock == 1) {
                      _checkPassword(
                        context,
                        settingViewModel.state.setting.password,
                      );
                    } else {
                      Navigator.pushNamed(context, SettingScreen.routeName);
                    }
                  },
                ),
              )
            : Container(),
        const SizedBox(
          width: 40,
        ),
      ],
      elevation: 0.0,
      backgroundColor: uiProvider.state.colorConst.canvas,
    ),
  );
}

void _checkPassword(
  BuildContext context,
  String? password,
) async {
  String? result;

  do {
    result = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => PasswordConfirmScreen(
          title: '비밀번호를 입력해주세요.',
          realPassword: password,
        ),
      ),
    ) as String?;
  } while (result != null && result != password);

  if (result == null) {
    /* do nothing */
  } else if (result == password) {
    Navigator.pushNamed(context, SettingScreen.routeName);
  }
}
