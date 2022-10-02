import 'package:flutter/material.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/off/weekly/off_weekly_event.dart';
import 'package:on_off/ui/off/weekly/off_weekly_state.dart';
import 'package:on_off/ui/off/weekly/off_weekly_view_model.dart';
import 'package:provider/provider.dart';

class OffWeeklyOrderChangeButton extends StatelessWidget {
  const OffWeeklyOrderChangeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OffWeeklyViewModel viewModel = context.watch<OffWeeklyViewModel>();
    OffWeeklyState state = viewModel.state;

    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: GestureDetector(
        onTap: () {
          viewModel.onEvent(const OffWeeklyEvent.changeDiaryOrderType());
        },
        child: Row(
          children: [
            Text(state.isAscending ? '오름차순' : '내림차순'),
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
    );
  }
}
