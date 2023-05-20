import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/ui/components/build_selected_icons.dart';
import 'package:on_off/ui/off/list/off_list_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
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
    UiProvider uiProvider = context.watch<UiProvider>();

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: uiProvider.state.colorConst.getPrimaryPlus(),
        borderRadius: BorderRadius.circular(7),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, .25),
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(1, -1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CompositedTransformTarget(
                link: selectIconSheetLink,
                child: Text(
                  DateFormat.MMMEd('ko_kr').format(content.time),
                  style: kBody2,
                ),
              ),
              viewModel.state.iconMap[content.time.day] == null
                  ? const SizedBox(width: 8)
                  : buildSelectedIcon(
                      viewModel.state.iconMap[content.time.day]!.name),
              Container(
                height: 2,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content.title,
            style: kOffTitle.copyWith(
              color: uiProvider.state.colorConst.darkGray,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              // color: const Color.fromRGBO(230, 247, 252, 0.3), // TODO : 논의. 배경색이 필요 없는것 같음.
            ),
            child: Column(
              children: [
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
      ),
    );
  }
}
