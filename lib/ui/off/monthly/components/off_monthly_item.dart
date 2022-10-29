import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/off/daily/off_daily_screen.dart';
import 'package:on_off/ui/off/gallery/off_gallery_screen.dart';
import 'package:on_off/ui/off/monthly/off_monthly_state.dart';
import 'package:on_off/ui/off/monthly/off_monthly_view_model.dart';
import 'package:on_off/ui/off/write/off_write_screen.dart';
import 'package:on_off/ui/provider/ui_event.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class OffMonthlyItem extends StatelessWidget {
  const OffMonthlyItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OffMonthlyViewModel viewModel = context.watch<OffMonthlyViewModel>();
    OffMonthlyState state = viewModel.state;
    UiProvider uiProvider = context.watch<UiProvider>();
    UiState uiState = uiProvider.state;
    LayerLink layerLink = LayerLink();

    return state.content == null
        ? Container(
            child: Column(
              children: [
                Image(
                  image: AssetImage(IconPath.noHaveContent.name),
                  width: 130,
                  height: 130,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  '이날은 아직 \n게시글이 없습니다!',
                  style: kSubtitle3.copyWith(
                    color: uiState.colorConst.getPrimary(),
                  ),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () {
                    uiProvider.onEvent(
                        const UiEvent.changeFloatingActionButtonSwitch(true));
                    Navigator.pushNamed(context, OffWriteScreen.routeName);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          18.0,
                        ),
                        side: BorderSide(
                          color: uiState.colorConst.getPrimary(),
                        ),
                      ),
                    ),
                  ),
                  child: const Text(
                    '글쓰러 가기',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            decoration: uiState.calendarFormat == CalendarFormat.week
                ? const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-3, -3),
                        blurRadius: 1,
                        spreadRadius: 1,
                        color: Color.fromRGBO(0, 0, 0, .1),
                      ),
                    ],
                  )
                : const BoxDecoration(),
            child: Container(
              decoration: uiState.calendarFormat == CalendarFormat.week
                  ? BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                      ),
                      color: uiProvider.state.colorConst.canvas,
                    )
                  : const BoxDecoration(),
              padding: EdgeInsets.only(
                top: uiState.calendarFormat == CalendarFormat.month ? 0 : 25,
                left: 37,
                right: 37,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CompositedTransformTarget(
                          link: layerLink,
                          child: Text(
                            DateFormat.MMMMEEEEd('ko_KR')
                                .format(state.content!.time),
                            style: kSubtitle2,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 23),
                    state.content!.imageList.isEmpty
                        ? const SizedBox()
                        : GestureDetector(
                            onTap: () {
                              uiProvider.onEvent(const UiEvent
                                  .changeFloatingActionButtonSwitch(true));
                              uiProvider.onEvent(
                                  const UiEvent.changeCalendarFormat(
                                      CalendarFormat.month));
                              Navigator.pushNamed(
                                context,
                                OffGalleryScreen.routeName,
                                arguments: {
                                  'offImageList': state.content?.imageList
                                },
                              );
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 74,
                              height: 240,
                              child: Image.memory(
                                state.content!.imageList.first.imageFile,
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width - 74,
                              ),
                            ),
                          ),
                    state.content!.imageList.isEmpty
                        ? const SizedBox()
                        : const SizedBox(height: 15),
                    Row(
                      children: [
                        const Text(
                          "오늘의 일기",
                          style: kSubtitle2,
                        ),
                        const SizedBox(
                          width: 40.5,
                        ),
                        Expanded(
                          child: Container(
                            height: 2,
                            decoration: const BoxDecoration(
                              color: Color(0xff219EBC),
                              borderRadius: BorderRadius.all(
                                Radius.circular(2.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    GestureDetector(
                      onTap: () {
                        uiProvider.onEvent(const UiEvent.changeCalendarFormat(
                            CalendarFormat.month));
                        Navigator.pushNamed(
                          context,
                          OffDailyScreen.routeName,
                          arguments: {
                            'content': state.content,
                            'icon': state.icon,
                          },
                        );
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 74,
                        child: Text(
                          state.content!.content,
                          textAlign: TextAlign.start,
                          softWrap: true,
                          style: kBody1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
