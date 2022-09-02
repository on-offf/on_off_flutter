// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:on_off/domain/icon/icon.dart';

class PlusButton extends StatelessWidget {
  bool isClicked;
  Function actionAfterClick;
  PlusButton({
    Key? key,
    required this.isClicked,
    required this.actionAfterClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(),
      onPressed: () => actionAfterClick(),
      icon: isClicked
          ? Image(
              image: AssetImage(IconPath.plus.name),
              width: 14,
              height: 14,
            )
          : Image(
              image: AssetImage(IconPath.minus.name),
              width: 14,
              height: 14,
            ),
    );
  }
}
