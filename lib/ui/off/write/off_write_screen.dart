import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/components/build_selected_icons.dart';
import 'package:on_off/ui/components/image_input.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/components/focus_month.dart';
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
                    child: FocusMonth(showOverlay: false,),
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
                            return GestureDetector(
                              onTap: () {
                                if (state!.imagePaths.length > 1) {
                                  viewModel?.onEvent(OffWriteEvent.removeImage(
                                      state!.imagePaths[index]));
                                } else {
                                  _imageRemoveFailDialog(uiState);
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                child: Image.file(
                                  state!.imagePaths[index].file,
                                  height: 40,
                                ),
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
    bool remove = await _removeDialog(uiState);
    if (remove) {
      viewModel?.onEvent(const OffWriteEvent.removeContent());
      uiProvider?.onEvent(const UiEvent.initScreen(OffMonthlyScreen.routeName));
      Future.delayed(Duration.zero, () => Navigator.pop(context));
    }
  }

  Future<dynamic> _imageRemoveFailDialog(uiState) {
    return showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(35.0),
          ),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          width: 288,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35.0),
            border: Border.all(
              width: 1,
              color: uiState.colorConst.getPrimary(),
            ),
            color: uiState.colorConst.canvas,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '하나 이상의 이미지를 등록해야 합니다.',
              style: kSubtitle3.copyWith(
                color: uiState.colorConst.getPrimary(),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _removeDialog(uiState) {
    return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (_) => Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(35.0),
          ),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          width: 288,
          height: 129,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35.0),
            border: Border.all(
              width: 1,
              color: uiState.colorConst.getPrimary(),
            ),
            color: uiState.colorConst.canvas,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 18,
              ),
              Text(
                '위 게시글을\n삭제하시습니까?',
                style: kSubtitle3.copyWith(
                  color: uiState.colorConst.getPrimary(),
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        side: BorderSide(
                          color: uiState.colorConst.getPrimary(),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    child: Text(
                      '예',
                      style: kSubtitle3.copyWith(
                        color: uiState.colorConst.getPrimary(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop(false);
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.0),
                        side: BorderSide(
                          color: uiState.colorConst.getPrimary(),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    child: Text(
                      '아니요',
                      style: kSubtitle3.copyWith(
                        color: uiState.colorConst.getPrimary(),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
