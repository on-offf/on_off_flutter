// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/ui/components/build_selected_icons.dart';
import 'package:on_off/ui/components/plus_button.dart';
import 'package:on_off/ui/off/list/off_list_event.dart';
import 'package:on_off/ui/off/list/off_list_state.dart';
import 'package:on_off/ui/off/list/off_list_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/provider/ui_state.dart';
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

    UiProvider uiProvider = context.watch<UiProvider>();
    UiState uiState = uiProvider.state;

    return Container(
      height: 177,
      child: Column(
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
              const SizedBox(width: 8,),
              if (state.iconPathMap![content.time.day] != null)
                ...buildSelectedIcons(state.iconPathMap![content.time.day]!) ,
              SizedBox(
                child: PlusButton(
                  layerLink: selectIconSheetLink,
                  actionAfterSelect: (path) => viewModel
                      .onEvent(OffListEvent.addSelectedIconPaths(content.time, path)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 2,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                DateFormat('오후 HH:MM', 'ko_KR').format(content.time),
                style: kSubtitle2,
              ),
              Expanded(
                child: SizedBox(),
              ),
            ],
          ),
          SizedBox(height: 3),
          content.imagePaths.isNotEmpty
              ? SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: content.imagePaths.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.0,
                        ),
                        child: Image.file(
                          File(content.imagePaths[index]),
                          height: 40,
                        ),
                      );
                    },
                  ),
                )
              : Container(),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 74,
            child: Text(
              content.content,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.start,
            ),
          ),
          // Expanded(
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: Row(
          //       // mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         content.imagePaths.isEmpty
          //             ? const SizedBox()
          //             : Image.asset(
          //                 content.imagePaths[0],
          //                 width: 96,
          //                 height: 81,
          //               ),
          //         content.imagePaths.isEmpty ? const SizedBox() : const SizedBox(width: 23),
          //         Expanded(
          //           child: Text(
          //             content.content,
          //             softWrap: true,
          //             maxLines: 4,
          //             overflow: TextOverflow.ellipsis,
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
