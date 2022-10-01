import 'package:flutter/material.dart';
import 'package:on_off/ui/components/common_floating_action_button.dart';
import 'package:on_off/ui/off/daily/off_daily_screen.dart';
import 'package:on_off/ui/components/focus_month.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/off/weekly/components/off_weekly_order_change_button.dart';
import 'package:on_off/ui/off/weekly/components/weekly_item.dart';
import 'package:on_off/ui/off/weekly/off_weekly_state.dart';
import 'package:on_off/ui/off/weekly/off_weekly_view_model.dart';
import 'package:provider/provider.dart';

class OffWeeklyScreen extends StatelessWidget {
  static const routeName = '/off/weekly';

  const OffWeeklyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OffWeeklyViewModel viewModel = context.watch<OffWeeklyViewModel>();
    OffWeeklyState state = viewModel.state;

    return Scaffold(
      appBar: offAppBar(
        context,
        isPrevButton: true,
      ),
      floatingActionButton: CommonFloatingActionButton(
        montlyWeeklyButtonNavigator: () {
          Navigator.pop(context);
        },
        onOffButtonNavigator: () {},
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 37,
          right: 37,
          bottom: 41,
        ),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
            itemBuilder: ((context, index) {
              if (index == 0) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FocusMonth(),
                    OffWeeklyOrderChangeButton(),
                  ],
                );
              } else {
                return GestureDetector(
                  child: WeeklyItem(content: state.contents[index - 1]),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      OffDailyScreen.routeName,
                      arguments: {
                        'content': state.contents[index - 1],
                        'iconPaths': state.iconPathMap[
                            state.contents[index - 1].time.weekday],
                      },
                    );
                  },
                );
              }
            }),
            itemCount: state.contents.length + 1,
          ),
        ),
      ),
    );
  }
}
