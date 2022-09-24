import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/components/build_selected_icons.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/components/off_focus_month.dart';
import 'package:on_off/ui/components/plus_button.dart';
import 'package:on_off/ui/off/write/components/icons_above_keyboard.dart';
import 'package:on_off/ui/off/write/off_write_event.dart';
import 'package:on_off/ui/off/write/off_write_state.dart';
import 'package:on_off/ui/off/write/off_write_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/provider/ui_state.dart';
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
  OffWriteViewModel? viewModel;

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
    Future.delayed(Duration.zero, () {
      viewModel!.onEvent(const OffWriteEvent.resetState());
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = context.watch<OffWriteViewModel>();
    OffWriteState state = viewModel!.state;

    UiProvider uiProvider = context.watch<UiProvider>();
    UiState uiState = uiProvider.state;

    return Scaffold(
      appBar: offAppBar(
        context,
        isPrevButton: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 37),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OffFocusMonth(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CompositedTransformTarget(
                      link: selectIconSheetLink,
                      child: Text(
                        DateFormat.MMMMEEEEd('ko_KR')
                            .format(uiState.focusedDay),
                        style: kSubtitle2,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ...buildSelectedIcons(state.iconPaths),
                    SizedBox(
                      child: PlusButton(
                          layerLink: selectIconSheetLink,
                          actionAfterSelect: (path) => viewModel!.onEvent(
                              OffWriteEvent.addSelectedIconPaths(path))),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        height: 2,
                        decoration: const BoxDecoration(
                          color: Color(0xff219EBC),
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "오후 ${DateFormat('kk:mm').format(DateTime.now())}분",
                  style: kSubtitle2,
                ),
                const SizedBox(
                  height: 5,
                ),
                state.imagePaths.isNotEmpty
                    ? SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.imagePaths.length,
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: Image.file(
                                state.imagePaths[index],
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
                  viewModel: viewModel!,
                  bodyController: bodyController)
              : const SizedBox(),
        ],
      ),
    );
  }
}
