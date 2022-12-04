// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:on_off/domain/icon/icon_path.dart';

class StickerButton extends StatefulWidget {
  LayerLink layerLink;
  Function actionAfterSelect;

  StickerButton({
    Key? key,
    required this.layerLink,
    required this.actionAfterSelect,
  }) : super(key: key);

  @override
  State<StickerButton> createState() => _StickerButtonState();
}

class _StickerButtonState extends State<StickerButton> {
  //off 화면의 아이콘 리스트
  List<String> iconPaths = [
    IconPath.expressionNormal.name,
    IconPath.expressionSmile.name,
    IconPath.expressionLittleSad.name,
    IconPath.expressionSmileEye.name,
    IconPath.expressionAngry.name,
    IconPath.expressionSmallEye.name,
    IconPath.expressionCry.name,
    IconPath.expressionLine.name,
    IconPath.expressionPairOfEye.name,
    IconPath.expressionReverse.name,
    IconPath.expressionSleep.name,
  ];

  bool isClicked = false;

  // 드롭박스.
  late final OverlayEntry overlayEntry =
      OverlayEntry(builder: _overlayEntryBuilder);
  static const double _dropdownWidth = 314;
  static const double _dropdownHeight = 254;

  // static  LayerLink link = widget.layerLink;

  // 드롭다운 생성.
  void _insertOverlay() {
    if (!overlayEntry.mounted) {
      OverlayState overlayState = Overlay.of(context)!;
      overlayState.insert(overlayEntry);
    }
  }

  // 드롭다운 해제.
  void _removeOverlay() {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
  }

  @override
  void dispose() {
    overlayEntry.dispose();
    super.dispose();
  }

  void clickAddIcon() {
    setState(() {
      isClicked = !isClicked;
      isClicked ? _insertOverlay() : _removeOverlay();
    });
  }

  void _actionAfterSelect(String imagePath) {
    setState(() {
      isClicked = false;
      widget.actionAfterSelect(imagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => clickAddIcon(),
      child: const Text(
        '오늘의 기분은?',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: .25,
          height: 1.66,
          color: Colors.black87,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget _overlayEntryBuilder(BuildContext _) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isClicked = !isClicked;
            });
            overlayEntry.remove();
          },
        ),
        Positioned(
          width: _dropdownWidth,
          height: _dropdownHeight,
          left: (MediaQuery.of(context).size.width / 2) - (_dropdownWidth / 2),
          top: (MediaQuery.of(context).size.height / 2) - (_dropdownHeight / 2),
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(29),
                color: Theme.of(context).canvasColor,
              ),
              child: GridView(
                padding: const EdgeInsets.all(30),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 60,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                children: [..._buildIconButtonList()],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<IconButton> _buildIconButtonList() {
    List<IconButton> res = [];
    for (var i in iconPaths) {
      res.add(_buildIconButton(i));
    }
    return res;
  }

  IconButton _buildIconButton(String imagePath) {
    return IconButton(
      onPressed: () {
        _removeOverlay();
        _actionAfterSelect(imagePath);
      },
      padding: const EdgeInsets.all(0),
      icon: Image(
        image: AssetImage(imagePath),
        width: 48,
        height: 48,
      ),
    );
  }
}
