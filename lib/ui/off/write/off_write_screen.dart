import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/components/build_selected_icons.dart';
import 'package:on_off/ui/components/image_input.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/components/simple_dialog.dart';
import 'package:on_off/ui/components/sticker_button.dart';
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

  const OffWriteScreen({Key? key}) : super(key: key);

  @override
  State<OffWriteScreen> createState() => _OffWriteScreenState();
}

class _OffWriteScreenState extends State<OffWriteScreen> {
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _bodyFocus = FocusNode();
  final TextEditingController titleController = TextEditingController();
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
    _bodyFocus.addListener(() {
      changeByFocus(_bodyFocus.hasFocus);
    });
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    _titleFocus.dispose();
    _bodyFocus.dispose();
    titleController.dispose();
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat.MMMMEEEEd('ko_KR').format(uiState!.focusedDay),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        height: 1.448,
                        letterSpacing: .25,
                      ),
                    ),
                    if (state!.icon != null)
                      buildSelectedIcon(state!.icon!.name),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 41,
                  child: TextField(
                    focusNode: _titleFocus,
                    controller: titleController,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      letterSpacing: .1,
                    ),
                    decoration: InputDecoration(
                      hintText: '제목을 입력해주세요.',
                      contentPadding: const EdgeInsets.only(left: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(18, 112, 176, 0.24)
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: const Color.fromRGBO(230, 247, 252, .3),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        state!.imagePaths.isNotEmpty
                            ? SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state!.imagePaths.length,
                                  itemBuilder: (ctx, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3.0),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            child: Image.file(
                                              state!.imagePaths[index].file,
                                              height: 140,
                                            ),
                                          ),
                                          Positioned(
                                            top: 5,
                                            right: 5,
                                            child: GestureDetector(
                                              onTap: () {
                                                if (state!.imagePaths.length >
                                                    1) {
                                                  viewModel?.onEvent(
                                                      OffWriteEvent.removeImage(
                                                          state!.imagePaths[
                                                              index]));
                                                } else {
                                                  _imageRemoveFailDialog(
                                                      uiState!);
                                                }
                                              },
                                              child: const Icon(Icons.cancel),
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
                        Container(
                          padding: const EdgeInsets.only(left: 8),
                          height: 41,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: StickerButton(
                            layerLink: selectIconSheetLink,
                            actionAfterSelect: (path) =>
                                viewModel?.onEvent(OffWriteEvent.addIcon(path)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            focusNode: _bodyFocus,
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
                            ),
                            maxLines: null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          isClicked
              ? IconsAboveKeyboard(
                  context: context,
                  titleController: titleController,
                  bodyController: bodyController,
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
        titleController.text = state!.offDiary!.title;
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
