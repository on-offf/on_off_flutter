import 'package:flutter/material.dart';
import 'package:on_off/ui/on/monthly/components/on_monthly_item.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../components/common_floating_action_button.dart';
import '../../components/focus_month.dart';
import '../../components/off_appbar.dart';
import '../../off/monthly/components/off_monthly_calendar.dart';
import '../../off/monthly/off_monthly_screen.dart';
import '../../provider/ui_provider.dart';
import 'on_monthly_view_model.dart';

class OnMonthlyScreen extends StatelessWidget {
  static const routeName = '/on/monthly';

  const OnMonthlyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = context.watch<UiProvider>();
    final viewModel = context.watch<OnMonthlyViewModel>();
    return Scaffold(
      // 작성 화면에서 바로 달력 화면으로 올 경우, 키보드가 늦게 내려가는 경우 키보드 사이즈가 위젯에 영향을 끼치지 못하도록 설정 (픽셀 초과 에러 방지)
      resizeToAvoidBottomInset: false,
      appBar: offAppBar(
        //TODO 이후 완전히 동일하면 공통 기능으로 빼기
        context,
        isPrevButton: false,
      ),
      floatingActionButton: CommonFloatingActionButton(
        montlyListButtonNavigator: () {
          uiProvider.changeCalendarFormat(CalendarFormat.month);
          // Navigator.pushNamed(context, OffListScreen.routeName); //TODO on 화면에서는 어떻게 이동하는지 결정
        },
        onOffButtonNavigator: () {
          Navigator.pushReplacementNamed(context, OffMonthlyScreen.routeName);
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
                  child: const SingleChildScrollView(
                      child:
                          OffMonthlyCalendar()), //TODO 이후 완전히 동일하면 공통 기능으로 빼기
                )
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                if (viewModel.state.todos != null) {
                  _positionChange(uiProvider, details);
                }
              },
              child: OnMonthlyItem(),
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
