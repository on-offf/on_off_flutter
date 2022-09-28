import 'package:carousel_slider/carousel_slider.dart';
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
            if (state.iconPathMap[content.time.weekday] != null)
              ...buildSelectedIcons(state.iconPathMap[content.time.weekday]!),
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
                height: 188,
                width: MediaQuery.of(context).size.width - 74,
                child: CarouselSlider(
                  items: content.imageList.map((offImage) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        offImage.imageFile,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width - 74,
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    viewportFraction: 1.0,
                    aspectRatio: 313 / 240,
                  ),
                ),
              )
            : Container(),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}