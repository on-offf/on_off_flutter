import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/components/build_selected_icons.dart';
import 'package:on_off/ui/components/image_input.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/components/focus_month.dart';
import 'package:on_off/ui/components/simple_dialog.dart';
import 'package:on_off/ui/off/monthly/off_monthly_screen.dart';
import 'package:on_off/ui/off/write/components/icons_above_keyboard.dart';
import 'package:on_off/ui/off/write/off_write_event.dart';
import 'package:on_off/ui/off/write/off_write_state.dart';
import 'package:on_off/ui/off/write/off_write_view_model.dart';
import 'package:on_off/ui/provider/ui_event.dart';
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
  OffWriteState? state;
  UiProvider? uiProvider;
  UiState? uiState;
  bool init = false;

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
    FocusManager.instance.primaryFocus?.unfocus();
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
    state = viewModel!.state;

    uiProvider = context.watch<UiProvider>();
    uiState = uiProvider!.state;

    if (!init) {
      init = true;
      _init();
    }

    return Scaffold(
      appBar: offAppBar(
        context,
        isPrevButton: true,
        settingButton: false,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 37),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  child: SizedBox(
                    width: 110,
                    child: FocusMonth(
                      showOverlay: false,
                    ),
                  ),
                ),
                Row(
                  children: [
                    CompositedTransformTarget(
                      link: selectIconSheetLink,
                      child: Text(
                        DateFormat.MMMMEEEEd('ko_KR')
                            .format(uiState!.focusedDay),
                        style: kSubtitle2,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    if (state!.icon != null)
                      buildSelectedIcon(state!.icon!.name),
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
                state!.imagePaths.isNotEmpty
                    ? SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state!.imagePaths.length,
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    child: Image.file(
                                      state!.imagePaths[index].file,
                                      height: 140,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (state!.imagePaths.length > 1) {
                                        viewModel?.onEvent(OffWriteEvent.removeImage(
                                            state!.imagePaths[index]));
                                      } else {
                                        _imageRemoveFailDialog(uiState!);
                                      }
                                    },
                                    child: const Positioned(
                                      top: 5,
                                      right: 5,
                                      child: Icon(Icons.cancel),
                                    ),
                                  ),
                                ],
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
                    decoration: InputDecoration(
                      hintText: '일기를 입력해주세요...',
                      focusedBorder: InputBorder.none,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: uiState!.colorConst.getLightGray(),
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
                  bodyController: bodyController,
                  selectIconSheetLink: selectIconSheetLink,
                  removeDialogFunction: removeDialogFunction,
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  void _init() async {
    viewModel!.onEvent(const OffWriteEvent.getFocusedDayDetail());

    Future.delayed(const Duration(milliseconds: 200), () {
      if (state?.offDiary != null) {
        bodyController.text = state!.offDiary!.content;
      } else {
        Future.delayed(Duration.zero, () async {
          var file = await inputImage(1);
          if (file == null) {
            Navigator.pop(context);
            return;
          }
          viewModel!.onEvent(OffWriteEvent.addSelectedImagePaths(file));
        });
      }
    });
  }

  void removeDialogFunction() async {
    FocusManager.instance.primaryFocus?.unfocus();
    bool remove = await _removeDialog(uiState!);
    if (remove) {
      viewModel?.onEvent(const OffWriteEvent.removeContent());
      uiProvider?.onEvent(const UiEvent.initScreen(OffMonthlyScreen.routeName));
      Future.delayed(Duration.zero, () => Navigator.pop(context));
    }
  }

  Future<dynamic> _removeDialog(UiState uiState) {
    return simpleConfirmButtonDialog(
      context,
      primaryColor: uiState.colorConst.getPrimary(),
      canvasColor: uiState.colorConst.canvas,
      message: '위 게시글을\n삭제하시습니까?',
      width: 288,
      height: 129,
    );
  }

  void _imageRemoveFailDialog(UiState uiState) {
    simpleTextDialog(
      context,
      primaryColor: uiState.colorConst.getPrimary(),
      canvasColor: uiState.colorConst.canvas,
      message: '하나 이상의 사진을 등록해야 합니다.',
    );
  }
}
