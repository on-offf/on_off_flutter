import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/components/off_appbar.dart';

class OffWriteScreen extends StatefulWidget {
  static const routeName = "/off/write";

  OffWriteScreen({Key? key}) : super(key: key);

  @override
  State<OffWriteScreen> createState() => _OffWriteScreenState();
}

class _OffWriteScreenState extends State<OffWriteScreen> {
  var bodyController = TextEditingController();
  bool isClicked = false;
  List<String> iconPaths = [];
  final LayerLink _selectIconSheet = LayerLink();

  IconButton _buildImage(String imagePath) {
    return IconButton(
      onPressed: () => selectIcon(imagePath),
      padding: EdgeInsets.all(0),
      icon: Image(
        image: AssetImage(imagePath),
        width: 48,
        height: 48,
      ),
    );
  }

  void selectIcon(String imagePath) {
    setState(() {
      isClicked = false;
      iconPaths.add(imagePath);
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
                      link: _selectIconSheet,
                      child: Text(
                        "8월 2일 목요일",
                        style: kSubtitle2,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    if (iconPaths.length > 0)
                      for (var i in iconPaths)
                        Image(
                          image: AssetImage(i),
                          width: 14,
                          height: 14,
                        ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () {
                        setState(() {
                          isClicked = !isClicked;
                        });
                      },
                      icon: isClicked
                          ? Image(
                              image: AssetImage("assets/icons/minus.png"),
                              width: 14,
                              height: 14,
                            )
                          : Image(
                              image: AssetImage("assets/icons/plus.png"),
                              width: 14,
                              height: 14,
                            ),
                    ),
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
                ? Positioned(
                    child: CompositedTransformFollower(
                      link: _selectIconSheet,
                      showWhenUnlinked: false,
                      offset: Offset(0, 23),
                      child: Container(
                        width: 314,
                        height: 254,
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(29),
                          color: Theme.of(context).canvasColor,
                        ),
                        child: GridView(
                          children: <Widget>[
                            _buildImage("assets/icons/expression_normal.png"),
                            _buildImage("assets/icons/expression_smile.png"),
                            _buildImage(
                                "assets/icons/expression_little_sad.png"),
                            _buildImage("assets/icons/expression_sleep.png"),
                            _buildImage("assets/icons/expression_angry.png"),
                            _buildImage(
                                "assets/icons/expression_small_eye.png"),
                            _buildImage("assets/icons/wine_glass.png"),
                            _buildImage("assets/icons/star.png"),
                            _buildImage("assets/icons/rice.png"),
                            _buildImage("assets/icons/note.png"),
                            _buildImage("assets/icons/weather_snow.png"),
                            _buildImage("assets/icons/weather_sunny.png"),
                          ],
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 60,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
