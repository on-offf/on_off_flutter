import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/ui/components/build_selected_icons.dart';
import 'package:on_off/ui/off/weekly/off_weekly_state.dart';
import 'package:on_off/ui/off/weekly/off_weekly_view_model.dart';
import 'package:provider/provider.dart';

class WeeklyItem extends StatelessWidget {
  final Content content;
  final LayerLink selectIconSheetLink = LayerLink();

  WeeklyItem({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OffWeeklyViewModel viewModel = context.watch<OffWeeklyViewModel>();
    OffWeeklyState state = viewModel.state;

    return Column(
      children: [
        Row(
          children: [
            CompositedTransformTarget(
              link: selectIconSheetLink,
              child: Text(
                DateFormat.MMMMEEEEd('ko_KR').format(content.time),
                style: kSubtitle2,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            if (state.iconPathMap[content.time.day] != null)
              ...buildSelectedIcons(state.iconPathMap[content.time.day]!),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 2,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        content.imageList.isNotEmpty
            ? SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: content.imageList.length,
                  itemBuilder: (ctx, index) {
                    return Image.memory(
                      content.imageList[index].imageFile,
                      width: MediaQuery.of(context).size.width - 74,
                    );
                  },
                ),
              )
            : Container(),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
