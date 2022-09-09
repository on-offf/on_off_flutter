import 'package:flutter/material.dart';

import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/components/build_selected_icons.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/components/plus_button.dart';
import 'package:on_off/ui/off/write/components/icons_above_keyboard.dart';
import 'package:on_off/ui/off/write/off_write_event.dart';
import 'package:on_off/ui/off/write/off_write_state.dart';
import 'package:on_off/ui/off/write/off_write_view_model.dart';
import 'package:provider/provider.dart';

class OffWriteScreen extends StatefulWidget {
  static const routeName = "/off/write";

  OffWriteScreen({Key? key}) : super(key: key);

  @override
  State<OffWriteScreen> createState() => _OffWriteScreenState();
}

class _OffWriteScreenState extends State<OffWriteScreen> {
  final FocusNode _focus = FocusNode();
  final TextEditingController bodyController = TextEditingController();
  final LayerLink selectIconSheetLink = LayerLink();
  bool isClicked = false;

  void changeByFocus(bool hasFocus) {
    if (hasFocus == true) {
      setState(() {
        isClicked = true;
      });
    } else {
      setState(() {
        isClicked = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      changeByFocus(_focus.hasFocus);
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OffWriteViewModel viewModel = context.watch<OffWriteViewModel>();
    OffWriteState state = viewModel.state;

    return Scaffold(
      appBar: offAppBar(context),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 37),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      "2022년 8월 첫째주",
                      style: kSubtitle1,
                    ),
                    SizedBox(
                      width: 6.38,
                    ),
                    Image(
                      image: AssetImage("assets/icons/down_arrow.png"),
                      width: 4.29,
                      height: 6.32,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CompositedTransformTarget(
                      link: selectIconSheetLink,
                      child: Text(
                        "8월 2일 목요일",
                        style: kSubtitle2,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ...buildSelectedIcons(state.iconPaths),
                    SizedBox(
                      child: PlusButton(
                        layerLink: selectIconSheetLink,
                        actionAfterSelect: (path) => viewModel
                            .onEvent(OffWriteEvent.addSelectedIconPaths(path)),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: Color(0xff219EBC),
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "오후 12:33분",
                  style: kSubtitle2,
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: TextField(
                    focusNode: _focus,
                    controller: bodyController,
                    style: kBody2,
                    decoration: const InputDecoration(
                      hintText: '일기를 입력해주세요...',
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                  ),
                ),
              ],
            ),
          ),
          isClicked
              ? IconsAboveKeyboard(
                  context: context,
                  viewModel: viewModel,
                  bodyController: bodyController)
              : SizedBox(),
        ],
      ),
    );
  }
}
