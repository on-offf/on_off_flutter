import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/components/build_selected_icons.dart';
import 'package:on_off/ui/components/focus_month.dart';
import 'package:on_off/ui/components/image_input.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/components/simple_dialog.dart';
import 'package:on_off/ui/components/sticker_button.dart';
import 'package:on_off/ui/components/transform_daily_weekly.dart';
import 'package:on_off/ui/off/list/off_list_screen.dart';
import 'package:on_off/ui/off/monthly/off_monthly_screen.dart';
import 'package:on_off/ui/off/write/components/icons_above_keyboard.dart';
import 'package:on_off/ui/off/write/off_write_view_model.dart';
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
  late OffWriteViewModel viewModel;
  late UiProvider uiProvider;
  bool init = false;
  late ScrollController _scrollController;
  final GlobalKey key = GlobalKey();
  double height = 300;

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

  void setHeight() {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    setState(
      () => height = MediaQuery.of(context).size.height -
          renderBox.localToGlobal(Offset.zero).dy -
          46,
    );
  }

  @override
  void initState() {
    super.initState();
    _bodyFocus.addListener(() {
      changeByFocus(_bodyFocus.hasFocus);
    });
    _scrollController = ScrollController();
  }

  @override
  void dispose() async {
    FocusManager.instance.primaryFocus?.unfocus();
    _titleFocus.dispose();
    _bodyFocus.dispose();
    titleController.dispose();
    bodyController.dispose();
    viewModel.resetState();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = context.watch<OffWriteViewModel>();
    uiProvider = context.watch<UiProvider>();
    setHeight();

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
            padding: const EdgeInsets.only(
              top: 10,
              left: 37,
              right: 37,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FocusMonth(
                      showOverlay: false,
                    ),
                    TransformDailyWeekly(
                      key: GlobalKey(),
                      isOverlay: false,
                    ),
                  ],
                ),
                Container(
                  key: key,
                  height: height,
                  padding: const EdgeInsets.symmetric(horizontal: 21),
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
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat.MMMMEEEEd('ko_KR')
                                .format(uiProvider.state.focusedDay),
                            style: kBody2,
                          ),
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
                          maxLength: 20,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            letterSpacing: .1,
                            color: uiProvider.state.colorConst.darkGray,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: '제목을 입력해주세요.',
                            counterText: '',
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
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: uiProvider.state.colorConst.getPrimaryPlus(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 1000,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            viewModel.state.imagePaths.isNotEmpty
                                ? SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: viewModel
                                                  .state.imagePaths.length <
                                              10
                                          ? viewModel.state.imagePaths.length +
                                              1
                                          : viewModel.state.imagePaths.length,
                                      itemBuilder: (ctx, index) {
                                        if (index ==
                                            viewModel.state.imagePaths.length) {
                                          return SizedBox(
                                            width: 100,
                                            child: IconButton(
                                              onPressed: () async {
                                                var pickedImage =
                                                    await inputImage(1);
                                                if (pickedImage == null) return;
                                                viewModel.addSelectedImagePaths(
                                                    pickedImage);
                                              },
                                              icon: const Icon(
                                                Icons.add_circle_outline,
                                                color: Colors.black38,
                                              ),
                                            ),
                                          );
                                        }
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
                                                  viewModel.state
                                                      .imagePaths[index].file,
                                                  height: 140,
                                                ),
                                              ),
                                              Positioned(
                                                top: 5,
                                                right: 5,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (viewModel.state
                                                            .imagePaths.length >
                                                        1) {
                                                      viewModel.removeImage(
                                                          viewModel.state
                                                                  .imagePaths[
                                                              index]);
                                                    } else {
                                                      _imageRemoveFailDialog(
                                                          uiProvider.state);
                                                    }
                                                  },
                                                  child:
                                                      const Icon(Icons.cancel),
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
                              height: 41,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Row(
                                children: [
                                  StickerButton(
                                    layerLink: selectIconSheetLink,
                                    actionAfterSelect: (path) =>
                                        viewModel.addIcon(path),
                                  ),
                                  if (viewModel.state.icon != null)
                                    _buildRemovableIcon(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: TextField(
                                focusNode: _bodyFocus,
                                controller: bodyController,
                                style: kBody2,
                                minLines: 8,
                                maxLines: 8,
                                decoration: InputDecoration(
                                  hintText: '일기를 입력해주세요...',
                                  contentPadding: const EdgeInsets.only(left: 0),
                                  focusedBorder: InputBorder.none,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  //키보드 높이 120 + 키보드 위 버튼들 높이 56
                                  _scrollController.animateTo(
                                    176,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
    await viewModel.getFocusedDayDetail();
    if (viewModel.state.offDiary != null) {
      titleController.text = viewModel.state.offDiary!.title;
      bodyController.text = viewModel.state.offDiary!.content;
    } else {
      var file = await inputImage(1);
      if (file == null) {
        Navigator.pop(context);
        return;
      }
      viewModel.addSelectedImagePaths(file);
    }
  }

  void removeDialogFunction() async {
    FocusManager.instance.primaryFocus?.unfocus();
    bool remove = await _removeDialog(uiProvider.state);
    if (remove) {
      await viewModel.removeContent();
      uiProvider.initScreen(OffMonthlyScreen.routeName);
      uiProvider.initScreen(OffListScreen.routeName);
      Future.delayed(
          Duration.zero,
          () => Navigator.pushNamedAndRemoveUntil(
              context, OffMonthlyScreen.routeName, (route) => false));
    }
  }

  Widget _buildRemovableIcon() {
    return GestureDetector(
        child: buildSelectedIcon(viewModel.state.icon!.name, uiProvider),
        onTap: () => viewModel.removeIcon(uiProvider.state.focusedDay));
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
