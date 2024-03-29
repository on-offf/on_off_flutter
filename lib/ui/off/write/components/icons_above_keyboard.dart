// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_off/constants/constants_text_style.dart';

import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/components/image_input.dart';
import 'package:on_off/ui/components/simple_dialog.dart';
import 'package:on_off/ui/off/daily/off_daily_screen.dart';
import 'package:on_off/ui/off/list/off_list_screen.dart';
import 'package:on_off/ui/off/monthly/off_monthly_screen.dart';
import 'package:on_off/ui/off/write/off_write_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:provider/provider.dart';

class IconsAboveKeyboard extends StatefulWidget {
  BuildContext context;
  final TextEditingController titleController;
  final TextEditingController bodyController;
  VoidCallback removeDialogFunction;

  IconsAboveKeyboard({
    Key? key,
    required this.context,
    required this.titleController,
    required this.bodyController,
    required this.removeDialogFunction,
  }) : super(key: key);

  @override
  State<IconsAboveKeyboard> createState() => _IconsAboveKeyboardState();
}

class _IconsAboveKeyboardState extends State<IconsAboveKeyboard> {
  File? _pickedImage;
  late UiProvider uiProvider;
  final int imageLimitNumber = 10;

  @override
  Widget build(BuildContext context) {
    OffWriteViewModel viewModel = context.watch<OffWriteViewModel>();
    uiProvider = context.watch<UiProvider>();

    return Positioned(
      bottom: 0,
      width: MediaQuery.of(context).size.width,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: uiProvider.state.colorConst.canvas,
          border: Border.symmetric(
            horizontal: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 38),
                IconButton(
                  onPressed: () async {
                    if (viewModel.state.imagePaths.length >= imageLimitNumber) {
                      _imageLimitTenDialog(uiProvider.state);
                    } else {
                      _pickedImage = await inputImage(0);
                      if (_pickedImage != null) {
                        viewModel.addSelectedImagePaths(_pickedImage!);
                        _pickedImage = null;
                      }
                    }
                  },
                  padding: const EdgeInsets.all(0),
                  icon: SvgPicture.asset(
                    IconPath.camera.name,
                    width: 37,
                    height: 35,
                    colorFilter: ColorFilter.mode(
                      uiProvider.state.colorConst.getPrimary(),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () async {
                    if (viewModel.state.imagePaths.length >= imageLimitNumber) {
                      _imageLimitTenDialog(uiProvider.state);
                    } else {
                      _pickedImage = await inputImage(1);
                      if (_pickedImage != null) {
                        viewModel.addSelectedImagePaths(_pickedImage!);
                        _pickedImage = null;
                      }
                    }
                  },
                  padding: const EdgeInsets.all(0),
                  icon: SvgPicture.asset(
                    IconPath.clip.name,
                    width: 29,
                    height: 29,
                    colorFilter: ColorFilter.mode(
                      uiProvider.state.colorConst.getPrimary(),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: widget.removeDialogFunction,
                  padding: const EdgeInsets.all(0),
                  icon: SvgPicture.asset(
                    IconPath.trashCan.name,
                    width: 29,
                    height: 29,
                    colorFilter: ColorFilter.mode(
                      uiProvider.state.colorConst.getPrimary(),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const VerticalDivider(
                  thickness: 2,
                  width: 2,
                  indent: 10,
                  endIndent: 10,
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context);

                    if (viewModel.state.imagePaths.isEmpty) {
                      _showImageRegistryDialog();
                      return;
                    }
                    if (widget.titleController.text.trim().isEmpty) {
                      _titleFailDialog(uiProvider.state);
                    } else if (widget.bodyController.text.trim().isEmpty) {
                      _contentFailDialog(uiProvider.state);
                    } else {
                      await viewModel.saveContent(widget.titleController.text,
                          widget.bodyController.text);
                      await uiProvider.initScreen(OffDailyScreen.routeName);
                      uiProvider.initScreen(OffMonthlyScreen.routeName);
                      uiProvider.initScreen(OffListScreen.routeName);

                      if (viewModel.state.offDiary?.id != null) {
                        bool? result = await simpleConfirmButtonDialog(
                          context,
                          primaryColor:
                              uiProvider!.state.colorConst.getPrimary(),
                          canvasColor: uiProvider!.state.colorConst.canvas,
                          message: "일기 수정을 끝내시겠습니까?",
                          trueButton: "네",
                          falseButton: "뒤로가기",
                          width: 215,
                          height: 134,
                        );
                        if (result != null && result) navigator.pop();
                      } else {
                        Navigator.of(context)
                            .popAndPushNamed(OffDailyScreen.routeName);
                      }
                    }
                  },
                  padding: const EdgeInsets.all(0),
                  icon: SvgPicture.asset(
                    IconPath.submit.name,
                    width: 30,
                    height: 30,
                    colorFilter: ColorFilter.mode(
                      uiProvider.state.colorConst.getPrimary(),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(width: 38),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showImageRegistryDialog() {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text(
          '사진을 1장 이상 등록해 주세요.',
          style: kBody1,
        ),
      ),
    );
  }

  void _imageLimitTenDialog(UiState uiState) {
    simpleTextDialog(
      context,
      primaryColor: uiState.colorConst.getPrimary(),
      canvasColor: uiState.colorConst.canvas,
      message: '사진은 최대 $imageLimitNumber장까지 등록 가능합니다.',
      // message: '사진은 최대 3장까지 등록 가능합니다.',
    );
  }

  void _titleFailDialog(UiState uiState) {
    simpleTextDialog(
      context,
      primaryColor: uiState.colorConst.getPrimary(),
      canvasColor: uiState.colorConst.canvas,
      message: '제목을 작성해 주세요',
    );
  }

  void _contentFailDialog(UiState uiState) {
    simpleTextDialog(
      context,
      primaryColor: uiState.colorConst.getPrimary(),
      canvasColor: uiState.colorConst.canvas,
      message: '본문을 작성해 주세요',
    );
  }
}
