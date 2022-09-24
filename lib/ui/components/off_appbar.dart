import 'package:flutter/material.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/provider/ui_event.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

PreferredSize offAppBar(BuildContext context, {required bool isPrevButton}) {
  final uiProvider = context.watch<UiProvider>();
  final uiState = uiProvider.state;

  return PreferredSize(
    preferredSize: const Size.fromHeight(77),
    child: AppBar(
      toolbarHeight: 77,
      leading: isPrevButton
          ? ElevatedButton(
              onPressed: () {
                uiProvider.onEvent(const UiEvent.changeFloatingActionButtonSwitch(true));
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
        GestureDetector(
          onTap: () {
            print('click setting');
          },
          child: Image(
            image: AssetImage(IconPath.setting.name),
            width: 24.17,
            height: 24.76,
          ),
        ),
        const SizedBox(
          width: 40,
        ),
      ],
      elevation: 0.0,
      backgroundColor: uiState.colorConst.canvas,
    ),
  );
}
