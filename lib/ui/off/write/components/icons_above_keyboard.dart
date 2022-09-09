// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/components/image_input.dart';
import 'package:on_off/ui/off/write/off_write_event.dart';
import 'package:on_off/ui/off/write/off_write_view_model.dart';

class IconsAboveKeyboard extends StatefulWidget {
  BuildContext context;
  OffWriteViewModel viewModel;
  TextEditingController bodyController;
  IconsAboveKeyboard({
    Key? key,
    required this.context,
    required this.viewModel,
    required this.bodyController,
  }) : super(key: key);

  @override
  State<IconsAboveKeyboard> createState() => _IconsAboveKeyboardState();
}

class _IconsAboveKeyboardState extends State<IconsAboveKeyboard> {
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  @override
  Widget build(BuildContext context) {
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
          children: [
            const SizedBox(width: 38),
            IconButton(
              onPressed: () {
                widget.viewModel.onEvent(
                    OffWriteEvent.saveTextContent(widget.bodyController.text));
              },
              padding: const EdgeInsets.all(0),
              icon: Image(
                image: AssetImage(IconPath.calendarAdd.name),
                width: 37,
                height: 35,
              ),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () async {
                await inputImage(0, _selectImage);
                if (_pickedImage != null) {
                  widget.viewModel.onEvent(
                      OffWriteEvent.addSelectedImagePaths(_pickedImage!));
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
                await inputImage(1, _selectImage);
                if (_pickedImage != null) {
                  widget.viewModel.onEvent(
                      OffWriteEvent.addSelectedImagePaths(_pickedImage!));
                  _pickedImage = null;
                }
              },
              padding: EdgeInsets.all(0),
              icon: Image(
                image: AssetImage(IconPath.clip.name),
                width: 29,
                height: 29,
              ),
            ),
            SizedBox(width: 20),
            IconButton(
              onPressed: () {},
              padding: EdgeInsets.all(0),
              icon: Image(
                image: AssetImage(IconPath.trashCan.name),
                width: 29,
                height: 29,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
