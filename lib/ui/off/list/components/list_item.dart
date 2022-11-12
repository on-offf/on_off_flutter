import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/ui/components/build_selected_icons.dart';
import 'package:on_off/ui/off/list/off_list_state.dart';
import 'package:on_off/ui/off/list/off_list_view_model.dart';
import 'package:provider/provider.dart';

class ListItem extends StatelessWidget {
  final Content content;
  final LayerLink selectIconSheetLink = LayerLink();

  ListItem({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OffListViewModel viewModel = context.watch<OffListViewModel>();
    OffListState state = viewModel.state;

    return Column(
      children: [
        Row(
          children: [
            CompositedTransformTarget(
              link: selectIconSheetLink,
              child: Text(
                DateFormat.MMMEd('ko_kr').format(content.time),
                style: kSubtitle2,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            if (state.iconMap.containsKey(content.time.day))
              buildSelectedIcon(state.iconMap[content.time.day]!.name),
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
        Container(
          height: 41,
          padding: const EdgeInsets.only(left: 8),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: const Color.fromRGBO(230, 247, 252, .59),
          ),
          child: Text(
            content.title,
            style: kSubtitle3,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: const Color.fromRGBO(230, 247, 252, 0.3),
          ),
          child: Column(
            children: [
              const SizedBox(height: 15),
              SizedBox(
                height: 145,
                width: MediaQuery.of(context).size.width - 74,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(
                    content.imageList[0].imageFile,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width - 74,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
