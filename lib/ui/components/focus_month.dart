import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/on/monthly/on_monthly_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class FocusMonth extends StatelessWidget {
  FocusMonth({
    Key? key,
    this.showOverlay = true,
    this.isAccent = false,
  }) : super(key: key);

  final GlobalKey _globalKey = GlobalKey();
  late UiProvider uiProvider;

  late RenderBox renderBox =
      _globalKey.currentContext?.findRenderObject() as RenderBox;
  late Size size = renderBox.size;
  late Offset offset = renderBox.localToGlobal(Offset.zero);

  bool showOverlay = true;
  bool isAccent = false;

  @override
  Widget build(BuildContext context) {
    uiProvider = context.watch<UiProvider>();
    OnMonthlyViewModel onMonthlyViewModel = context.watch<OnMonthlyViewModel>();

    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 17),
      child: GestureDetector(
        onTap: () {
          if (!showOverlay) return;
          onMonthlyViewModel.unFocus();

          uiProvider.focusMonthSelected();
          if (uiProvider.state.focusMonthSelected) {
            OverlayEntry overlayEntry = _createOverlay();
            Navigator.of(context).overlay?.insert(overlayEntry);
            uiProvider.showOverlay(context, overlayEntry);
          } else {
            uiProvider.removeOverlay();
          }
        },
        child: Row(
          children: [
            Container(
              key: _globalKey,
              child: Text(
                DateFormat('yyyy년 MM월', 'ko_KR')
                    .format(uiProvider.state.changeCalendarPage),
                style: isAccent
                    ? kSubtitle2.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      )
                    : kSubtitle2,
              ),
            ),
            const SizedBox(
              width: 6.38,
            ),
            SvgPicture.asset(
              IconPath.downArrow.name,
              colorFilter: ColorFilter.mode(
                  uiProvider.state.colorConst.getPrimary(), BlendMode.srcIn),
              width: 12,
            ),
          ],
        ),
      ),
    );
  }

  OverlayEntry _createOverlay() {
    DateTime focusedDay = uiProvider.state.focusedDay;
    int year = focusedDay.year;

    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => uiProvider.removeOverlay(),
              onHorizontalDragDown: (_) => uiProvider.removeOverlay(),
            ),
            Positioned(
              left: isAccent ? offset.dx - 26 : offset.dx,
              top: offset.dy + size.height,
              // width: 162,
              // height: 171,
              width: 188,
              height: 195,
              child: Material(
                color: Colors.transparent,
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
                    ],
                  ),
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
                                uiProvider.selfNotifyListeners();
                              },
                              icon: SvgPicture.asset(
                                IconPath.previousYearButton.name,
                                height: 11,
                                width: 11,
                                colorFilter: ColorFilter.mode(
                                    uiProvider.state.colorConst.getPrimary(),
                                    BlendMode.srcIn),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0.0, bottom: 0, left: 0, right: 0),
                            child: Text(
                              "$year",
                              style: kSubtitle3.copyWith(
                                  color:
                                      uiProvider.state.colorConst.getPrimary()),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 4.0, bottom: 0, left: 0, right: 0),
                            child: IconButton(
                              onPressed: () {
                                year = year + 1;
                                uiProvider.selfNotifyListeners();
                              },
                              icon: SvgPicture.asset(
                                IconPath.nextYearButton.name,
                                height: 11,
                                width: 11,
                                colorFilter: ColorFilter.mode(
                                    uiProvider.state.colorConst.getPrimary(),
                                    BlendMode.srcIn),
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
                      // Expanded(
                      //   child: GridView.builder(
                      //     itemCount: 12,
                      //     gridDelegate:
                      //         const SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 4, //1 개의 행에 보여줄 item 개수
                      //       childAspectRatio: 1 / 1, //item 의 가로 2, 세로 1 의 비율
                      //       mainAxisSpacing: 15, //수평 Padding
                      //       crossAxisSpacing: 15, //수직 Padding
                      //     ),
                      //     itemBuilder: (BuildContext _, int i) {
                      //       return monthSelectButton(year, (i + 1).toString());
                      //     },
                      //   ),
                      // ),
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
    DateTime focusedDay = uiProvider.state.focusedDay;
    bool isFocusMonth =
        focusedDay.year == year && focusedDay.month == int.parse(month);

    return Expanded(
      child: SizedBox(
        height: 41,
        child: TextButton(
          onPressed: () {
            uiProvider
                .changeFocusedDay(DateTime.utc(year, int.parse(month), 1));
            uiProvider
                .changeCalendarPage(DateTime.utc(year, int.parse(month), 1));
            uiProvider.removeOverlay();
          },
          style: !isFocusMonth
              ? TextButton.styleFrom()
              : TextButton.styleFrom(
                  backgroundColor: uiProvider.state.colorConst.getPrimary(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    side: BorderSide(
                      color: uiProvider.state.colorConst.getPrimary(),
                    ),
                  ),
                ),
          child: Text(
            month,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: !isFocusMonth
                  ? uiProvider.state.colorConst.getPrimary()
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
