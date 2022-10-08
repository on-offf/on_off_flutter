import 'package:flutter/material.dart';
import 'package:on_off/ui/components/common_floating_action_button.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/components/focus_month.dart';
import 'package:on_off/ui/off/monthly/components/off_monthly_calendar.dart';
import 'package:on_off/ui/off/monthly/components/off_monthly_item.dart';
import 'package:on_off/ui/off/list/off_weekly_screen.dart';
import 'package:on_off/ui/provider/ui_event.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class OffMonthlyScreen extends StatelessWidget {
  static const routeName = '/off/monthly';
  final ScrollController _scrollController = ScrollController();

  OffMonthlyScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final uiProvider = context.watch<UiProvider>();
    final uiState = uiProvider.state;

    return Scaffold(
      // 작성 화면에서 바로 달력 화면으로 올 경우, 키보드가 늦게 내려가는 경우 키보드 사이즈가 위젯에 영향을 끼치지 못하도록 설정 (픽셀 초과 에러 방지)
      resizeToAvoidBottomInset: false,
      appBar: offAppBar(
        context,
        isPrevButton: false,
      ),
      floatingActionButton: CommonFloatingActionButton(
        montlyListButtonNavigator: () {
          uiProvider.onEvent(const UiEvent.changeCalendarFormat(CalendarFormat.month));
          Navigator.pushNamed(context, OffListScreen.routeName);
        },
        onOffButtonNavigator: () {},
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 37,
              right: 37,
            ),
            child: Column(
              children: [
                FocusMonth(),
                const OffMonthlyCalendar(),
                uiState.calendarFormat == CalendarFormat.month
                    ? const SizedBox(
                        height: 47.5,
                      )
                    : Container(),
              ],
            ),
          ),
          Expanded(
            child: NotificationListener(
              onNotification: (ScrollNotification scrollNotification) {
                var position = _scrollController.position;
                positionChange(uiProvider, position);
                return uiState.calendarFormat == CalendarFormat.month;
              },
              child: ListView(
                controller: _scrollController,
                children: const [
                  OffMonthlyItem(),
                  SizedBox(height: 41),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> positionChange(uiProvider, position) async {
    if (position.pixels < 0) {
      uiProvider
          .onEvent(const UiEvent.changeCalendarFormat(CalendarFormat.month));
    } else if (position.pixels > 0) {
      uiProvider
          .onEvent(const UiEvent.changeCalendarFormat(CalendarFormat.week));
    }
  }
}
