import 'package:flutter/material.dart';
import 'package:on_off/ui/components/common_floating_action_button.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/components/focus_month.dart';
import 'package:on_off/ui/components/monthly_calendar.dart';
import 'package:on_off/ui/off/monthly/components/off_monthly_item.dart';
import 'package:on_off/ui/off/list/off_list_screen.dart';
import 'package:on_off/ui/off/monthly/off_monthly_view_model.dart';
import 'package:on_off/ui/on/monthly/on_monthly_screen.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class OffMonthlyScreen extends StatelessWidget {
  static const routeName = '/off/monthly';

  const OffMonthlyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = context.watch<UiProvider>();
    final viewModel = context.watch<OffMonthlyViewModel>();

    return Scaffold(
      // 작성 화면에서 바로 달력 화면으로 올 경우, 키보드가 늦게 내려가는 경우 키보드 사이즈가 위젯에 영향을 끼치지 못하도록 설정 (픽셀 초과 에러 방지)
      resizeToAvoidBottomInset: false,
      appBar: offAppBar(
        context,
        isPrevButton: false,
      ),
      floatingActionButton: CommonFloatingActionButton(
        montlyListButtonNavigator: () {
          uiProvider.changeCalendarFormat(CalendarFormat.month);
          Navigator.pushNamed(context, OffListScreen.routeName);
        },
        onOffButtonNavigator: () {
          Navigator.pushReplacementNamed(context, OnMonthlyScreen.routeName);
        },
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
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height:
                      uiProvider.state.calendarFormat == CalendarFormat.month
                          ? 320
                          : 70,
                  child:
                      const SingleChildScrollView(child: MonthlyCalendar()),
                )
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                if (viewModel.state.content != null) {
                  _positionChange(uiProvider, details);
                }
              },
              child: OffMonthlyItem(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _positionChange(uiProvider, details) async {
    if (details.primaryVelocity! > 0) {
      uiProvider.changeCalendarFormat(CalendarFormat.month);
    } else if (details.primaryVelocity! < 0) {
      uiProvider.changeCalendarFormat(CalendarFormat.week);
    }
  }
}
