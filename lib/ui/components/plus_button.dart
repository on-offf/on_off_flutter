// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:on_off/domain/icon/icon_path.dart';

class PlusButton extends StatefulWidget {
  List<String> seletcedIconPaths;
  LayerLink layerLink;
  Function actionAfterSelect;
  PlusButton({
    Key? key,
    required this.seletcedIconPaths,
    required this.layerLink,
    required this.actionAfterSelect,
  }) : super(key: key);

  @override
  State<PlusButton> createState() => _PlusButtonState();
}

class _PlusButtonState extends State<PlusButton> {
  //off 화면의 아이콘 리스트
  List<String> iconPaths = [
    IconPath.expressionNormal.name,
    IconPath.expressionSmile.name,
    IconPath.expressionLittleSad.name,
    IconPath.expressionSleep.name,
    IconPath.expressionAngry.name,
    IconPath.expressionSmallEye.name,
    IconPath.wineGlass.name,
    IconPath.star.name,
    IconPath.rice.name,
    IconPath.note.name,
    IconPath.weatherSnow.name,
    IconPath.weatherSunny.name,
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
      // widget.seletcedIconPaths.add(imagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(),
      onPressed: () => clickAddIcon(),
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

  Widget _overlayEntryBuilder(BuildContext _) {
    LayerLink link = widget.layerLink;
    return Positioned(
      width: _dropdownWidth,
      height: _dropdownHeight,
      child: CompositedTransformFollower(
        link: link,
        // showWhenUnlinked: false,
        offset: Offset(0, 23),
        child: Material(
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
              padding: EdgeInsets.all(30),
              children: [..._buildIconButtonList()],
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 60,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
            ),
          ),
        ),
      ),
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
        _actionAfterSelect(imagePath);
        _removeOverlay();
      },
      // onPressed: () => print(imagePath),
      padding: EdgeInsets.all(0),
      icon: Image(
        image: AssetImage(imagePath),
        width: 48,
        height: 48,
      ),
    );
  }
}
