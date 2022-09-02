import 'package:flutter/material.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/components/build_selected_icons.dart';
import 'package:on_off/ui/components/icon_sheet.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/components/plus_button.dart';

class OffWriteScreen extends StatefulWidget {
  static const routeName = "/off/write";

  OffWriteScreen({Key? key}) : super(key: key);

  @override
  State<OffWriteScreen> createState() => _OffWriteScreenState();
}

class _OffWriteScreenState extends State<OffWriteScreen> {
  var bodyController = TextEditingController();
  bool isClicked = false;
  List<String> seletcedIconPaths = [];

  final LayerLink selectIconSheetLink = LayerLink();

  void clickAddIcon() {
    setState(() {
      isClicked = !isClicked;
    });
  }

  void actionAfterSelect(String imagePath) {
    setState(() {
      isClicked = false;
      seletcedIconPaths.add(imagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: offAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 37),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      "2022년 8월 첫째주",
                      style: kSubtitle1,
                    ),
                    SizedBox(
                      width: 6.38,
                    ),
                    Image(
                      image: AssetImage("assets/icons/down_arrow.png"),
                      width: 4.29,
                      height: 6.32,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CompositedTransformTarget(
                      link: selectIconSheetLink,
                      child: Text(
                        "8월 2일 목요일",
                        style: kSubtitle2,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ...buildSelectedIcons(seletcedIconPaths),
                    PlusButton(
                        isClicked: isClicked, actionAfterClick: clickAddIcon),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: Color(0xff219EBC),
                          borderRadius: BorderRadius.all(
                            Radius.circular(2.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "오후 12:33분",
                  style: kSubtitle2,
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: TextField(
                    controller: bodyController,
                    style: kBody2,
                    decoration: const InputDecoration(
                      hintText: '일기를 입력해주세요...',
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            isClicked
                ? IconSheet(
                    context: context,
                    link: selectIconSheetLink,
                    actionAfterSelect: actionAfterSelect,
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
