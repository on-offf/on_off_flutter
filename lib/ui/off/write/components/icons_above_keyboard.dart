// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:on_off/constants/constants_text_style.dart';

import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/components/image_input.dart';
import 'package:on_off/ui/components/simple_dialog.dart';
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
  UiProvider? uiProvider;
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
          color: Theme.of(context).canvasColor,
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
                    _pickedImage = await inputImage(0);
                    if (_pickedImage != null) {
                      viewModel.addSelectedImagePaths(_pickedImage!);
                      _pickedImage = null;
                    }
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Image(
                    image: AssetImage(IconPath.camera.name),
                    width: 37,
                    height: 35,
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () async {
                    if (viewModel.state.imagePaths.length >= imageLimitNumber) {
                      //TODO 질문 : > 사용해서 +1, -1을 하면 왜 안됨?
                      _imageLimitTenDialog(uiProvider!.state);
                    } else {
                      _pickedImage = await inputImage(1);
                      if (_pickedImage != null) {
                        viewModel.addSelectedImagePaths(_pickedImage!);
                        _pickedImage = null;
                      }
                    }
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Image(
                    image: AssetImage(IconPath.clip.name),
                    width: 29,
                    height: 29,
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: widget.removeDialogFunction,
                  padding: const EdgeInsets.all(0),
                  icon: Image(
                    image: AssetImage(IconPath.trashCan.name),
                    width: 29,
                    height: 29,
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
                const SizedBox(width: 10,),
                IconButton(
                  onPressed: () {
                    if (viewModel.state.imagePaths.isEmpty) {
                      _showImageRegistryDialog();
                      return;
                    }
                    viewModel.saveContent(widget.titleController.text, widget.bodyController.text);
                    uiProvider?.initScreen(OffMonthlyScreen.routeName);
                    Navigator.of(context).pop();
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Image(
                    image: AssetImage(IconPath.submit.name),
                    width: 30,
                    height: 30,
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
          '사진을 1장 이상 등록해주세요.',
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
}
