import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/provider/ui_event.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:provider/provider.dart';

class FocusMonth extends StatelessWidget {
  FocusMonth({Key? key}) : super(key: key);
  final GlobalKey _globalKey = GlobalKey();
  late UiProvider uiProvider;
  late UiState uiState;

  late RenderBox renderBox =
      _globalKey.currentContext?.findRenderObject() as RenderBox;
  late Size size = renderBox.size;
  late Offset offset = renderBox.localToGlobal(Offset.zero);

  @override
  Widget build(BuildContext context) {
    uiProvider = context.watch<UiProvider>();
    uiState = uiProvider.state;

    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              uiProvider.onEvent(const UiEvent.focusMonthSelected());
              if (uiState.focusMonthSelected) {
                OverlayEntry overlayEntry = _createOverlay();
                Navigator.of(context).overlay?.insert(overlayEntry);
                uiProvider.onEvent(UiEvent.showOverlay(context, overlayEntry));
              } else {
                uiProvider.onEvent(const UiEvent.removeOverlay());
              }
            },
            child: Row(
              children: [
                Container(
                  key: _globalKey,
                  child: Text(
                    DateFormat('yyyy년 MM월', 'ko_KR')
                        .format(uiState.changeCalendarPage),
                    style: kSubtitle2,
                  ),
                ),
                const SizedBox(
                  width: 6.38,
                ),
                Image(
                  image: AssetImage(IconPath.downArrow.name),
                  width: 4.29,
                  height: 6.32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  OverlayEntry _createOverlay() {
    DateTime focusedDay = uiState.focusedDay;
    int year = focusedDay.year;

    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => uiProvider.onEvent(const UiEvent.removeOverlay()),
            ),
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height,
              width: 162,
              height: 171,
              child: Material(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                        )
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 4, bottom: 0, left: 0, right: 0),
                            child: IconButton(
                              onPressed: () {
                                year = year - 1;
                                uiProvider.onEvent(
                                    const UiEvent.selfNotifyListeners());
                              },
                              icon: Image(
                                image: AssetImage(
                                  IconPath.previousYearButton.name,
                                ),
                                height: 11,
                                width: 11,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0.0, bottom: 0, left: 0, right: 0),
                            child: Text(
                              "$year",
                              style: kSubtitle3,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 4.0, bottom: 0, left: 0, right: 0),
                            child: IconButton(
                              onPressed: () {
                                year = year + 1;
                                uiProvider.onEvent(
                                    const UiEvent.selfNotifyListeners());
                              },
                              icon: Image(
                                image:
                                    AssetImage(IconPath.nextYearButton.name),
                                height: 11,
                                width: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(children: [
                        const SizedBox(
                          width: 16,
                        ),
                        monthSelectButton(year, '1'),
                        monthSelectButton(year, '2'),
                        monthSelectButton(year, '3'),
                        monthSelectButton(year, '4'),
                        const SizedBox(
                          width: 16,
                        ),
                      ]),
                      Row(children: [
                        const SizedBox(
                          width: 16,
                        ),
                        monthSelectButton(year, '5'),
                        monthSelectButton(year, '6'),
                        monthSelectButton(year, '7'),
                        monthSelectButton(year, '8'),
                        const SizedBox(
                          width: 16,
                        ),
                      ]),
                      Row(children: [
                        const SizedBox(
                          width: 16,
                        ),
                        monthSelectButton(year, '9'),
                        monthSelectButton(year, '10'),
                        monthSelectButton(year, '11'),
                        monthSelectButton(year, '12'),
                        const SizedBox(
                          width: 16,
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget monthSelectButton(int year, String month) {
    DateTime focusedDay = uiState.focusedDay;
    bool isFocusMonth =
        focusedDay.year == year && focusedDay.month == int.parse(month);

    return Expanded(
      child: SizedBox(
        height: 31,
        child: TextButton(
          onPressed: () {
            uiProvider.onEvent(UiEvent.changeFocusedDay(
                DateTime.utc(year, int.parse(month), 1)));
            uiProvider.onEvent(const UiEvent.removeOverlay());
          },
          style: !isFocusMonth
              ? TextButton.styleFrom()
              : TextButton.styleFrom(
                  backgroundColor: uiState.colorConst.getPrimary(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    side: BorderSide(
                      color: uiState.colorConst.getPrimary(),
                    ),
                  ),
                ),
          child: Text(
            month,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: !isFocusMonth ? uiState.colorConst.getPrimary() : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
