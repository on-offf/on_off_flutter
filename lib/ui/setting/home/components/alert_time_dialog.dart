import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/model/alert_time.dart';
import 'package:on_off/ui/provider/ui_event.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:on_off/ui/setting/home/setting_state.dart';
import 'package:on_off/ui/setting/home/setting_view_model.dart';

Future<AlertTime?> alertTimeDialog(
  BuildContext context,
  SettingViewModel viewModel,
  SettingState state,
  UiProvider uiProvider,
  UiState uiState,
  Color primaryColor,
) {
  DateTime dateTime = DateTime.now();

  /* TRUE : AM & FALSE : PM */
  bool meridiem = DateTime.now().hour < 12;
  int hour = dateTime.hour < 12
          ? dateTime.hour
          : dateTime.hour - 12;
  int minutes = dateTime.minute;

  FixedExtentScrollController hourController =
      FixedExtentScrollController(initialItem: dateTime.hour < 12 ? dateTime.hour : dateTime.hour - 12);
  FixedExtentScrollController minuteController =
      FixedExtentScrollController(initialItem: minutes);

  return showDialog(
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
        width: 231,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.0),
          border: Border.all(
            width: 1,
            color: primaryColor,
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 26,
            ),
            SizedBox(
              height: 65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 32),
                  Column(
                    children: [
                      SizedBox(
                        height: 30,
                        child: TextButton(
                          onPressed: () {
                            meridiem = true;
                            uiProvider
                                .onEvent(const UiEvent.selfNotifyListeners());
                          },
                          style: meridiemButtonStyle(),
                          child: Text(
                            'AM',
                            style: meridiemTextStyle().copyWith(
                              color: meridiem ? primaryColor : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: TextButton(
                          onPressed: () {
                            meridiem = false;
                            uiProvider
                                .onEvent(const UiEvent.selfNotifyListeners());
                          },
                          style: meridiemButtonStyle(),
                          child: Text(
                            'PM',
                            style: meridiemTextStyle().copyWith(
                              color: meridiem ? Colors.grey : primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 60,
                    height: 65,
                    padding: timePadding(),
                    child: CupertinoPicker.builder(
                      scrollController: hourController,
                      selectionOverlay:
                          const CupertinoPickerDefaultSelectionOverlay(
                        background: Colors.transparent,
                      ),
                      itemExtent: 52,
                      onSelectedItemChanged: (int value) {
                        hour = value;
                        uiProvider.onEvent(const UiEvent.selfNotifyListeners());
                      },
                      childCount: 12,
                      itemBuilder: (context, index) {
                        int h = index;
                        if (index == 0) h = 12;
                        return Text(
                          '${h < 10 ? '0' : ''}$h',
                          style: timeTextStyle(),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: 15,
                    height: 65,
                    padding: timePadding(),
                    child: Text(
                      ':',
                      style: timeTextStyle(),
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 65,
                    padding: timePadding(),
                    child: CupertinoPicker.builder(
                      scrollController: minuteController,
                      itemExtent: 52,
                      selectionOverlay:
                          const CupertinoPickerDefaultSelectionOverlay(
                        background: Colors.transparent,
                      ),
                      onSelectedItemChanged: (int value) {
                        minutes = value;
                      },
                      backgroundColor: Colors.transparent,
                      childCount: 60,
                      itemBuilder: (context, index) {
                        return Text(
                          '${index < 10 ? '0' : ''}$index',
                          style: timeTextStyle(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    var time = AlertTime(
                      hour: meridiem ? hour : hour + 12,
                      minutes: minutes,
                    );
                    Navigator.of(context).pop(
                      time,
                    );
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                      side: BorderSide(
                        color: primaryColor,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Text(
                    '예',
                    style: kSubtitle3.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                      side: BorderSide(
                        color: primaryColor,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Text(
                    '아니요',
                    style: kSubtitle3.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

TextStyle meridiemTextStyle() {
  return const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 1.67,
    letterSpacing: .1,
  );
}

ButtonStyle meridiemButtonStyle() {
  return TextButton.styleFrom(
    padding: const EdgeInsets.all(0),
  );
}

EdgeInsets timePadding() {
  return const EdgeInsets.only(
    top: 0,
    bottom: 12,
    left: 0,
    right: 0,
  );
}

TextStyle timeTextStyle() {
  return const TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 1.311,
    letterSpacing: .1,
  );
}
