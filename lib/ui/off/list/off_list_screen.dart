import 'package:flutter/material.dart';
import 'package:on_off/ui/components/common_floating_action_button.dart';
import 'package:on_off/ui/off/detail/off_detail_screen.dart';
import 'package:on_off/ui/components/off_focus_month.dart';
import 'package:on_off/ui/off/list/components/list_item.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/off/list/off_list_state.dart';
import 'package:on_off/ui/off/list/off_list_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:provider/provider.dart';

class OffListScreen extends StatelessWidget {
  static const routeName = '/off/list';

  const OffListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OffListViewModel viewModel = context.watch<OffListViewModel>();
    OffListState state = viewModel.state;
    UiProvider uiProvider = context.watch<UiProvider>();
    UiState uiState = uiProvider.state;

    return Scaffold(
      appBar: offAppBar(
        context,
        isPrevButton: true,
      ),
      floatingActionButton: CommonFloatingActionButton(
        montlyWeeklyButtonNavigator: () {
          Navigator.pop(context);
        },
        onOffButtonNavigator: () { },
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
                return OffFocusMonth();
              } else {
                return GestureDetector(
                  child: ListItem(content: state.contents[index - 1]),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      OffDetailScreen.routeName,
                      arguments: {
                        'content': state.contents[index - 1],
                        'iconPaths': state
                            .iconPathMap![state.contents[index - 1].time.day],
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
