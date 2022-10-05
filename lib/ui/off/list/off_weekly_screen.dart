import 'package:flutter/material.dart';
import 'package:on_off/ui/components/common_floating_action_button.dart';
import 'package:on_off/ui/off/daily/off_daily_screen.dart';
import 'package:on_off/ui/components/focus_month.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/off/weekly/components/off_list_order_change_button.dart';
import 'package:on_off/ui/off/weekly/components/list_item.dart';
import 'package:on_off/ui/off/weekly/off_list_state.dart';
import 'package:on_off/ui/off/weekly/off_list_view_model.dart';
import 'package:provider/provider.dart';

class OffListScreen extends StatelessWidget {
  static const routeName = '/off/list';

  const OffListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OffListViewModel viewModel = context.watch<OffListViewModel>();
    OffListState state = viewModel.state;

    return Scaffold(
      appBar: offAppBar(
        context,
        isPrevButton: true,
      ),
      floatingActionButton: CommonFloatingActionButton(
        montlyListButtonNavigator: () {
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
                    OffListOrderChangeButton(),
                  ],
                );
              } else {
                return GestureDetector(
                  child: ListItem(content: state.contents[index - 1]),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      OffDailyScreen.routeName,
                      arguments: {
                        'content': state.contents[index - 1],
                        'icon': state.iconMap[state.contents[index - 1].time.day],
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
