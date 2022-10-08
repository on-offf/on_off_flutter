import 'package:flutter/material.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/setting';

  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = context.watch<UiProvider>();
    final uiState = uiProvider.state;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: uiState.colorConst.getPrimary(),
        elevation: 0,
        leading: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: uiState.colorConst.getPrimary(),
            elevation: 0,
          ),
          child: Image(
            image: AssetImage(IconPath.appbarPreviousButton.name),
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text(
          '설정',
          style: kBody2,
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: titleEdgeInsets(),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '알림설정',
                style: titleTextStyle(),
              ),
            ),
          ),
          Container(
            padding: buttonEdgeInsets(),
            color: Colors.white,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '화면잠금',
                style: buttonTextStyle(),
              ),
            ),
          ),
          divide(),
          Container(
            padding: buttonEdgeInsets(),
            color: Colors.white,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '알림',
                style: buttonTextStyle(),
              ),
            ),
          ),
          Container(
            padding: titleEdgeInsets(),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '피드백',
                style: titleTextStyle(),
              ),
            ),
          ),
          Container(
            padding: buttonEdgeInsets(),
            color: Colors.white,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '리뷰는 큰 힘이 됩니다!',
                style: buttonTextStyle(),
              ),
            ),
          ),
          divide(),
          Container(
            padding: buttonEdgeInsets(),
            color: Colors.white,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '아쉬운 점을 알려주세요!',
                style: buttonTextStyle(),
              ),
            ),
          ),
          divide(),
          Container(
            padding: buttonEdgeInsets(),
            color: Colors.white,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '버전관리',
                style: buttonTextStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container divide() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 0),
      color: Colors.white,
      child: const Divider(
        thickness: 1.5,
        height: 0,
        color: Color.fromARGB(40, 0, 0, 0),
      ),
    );
  }

  TextStyle buttonTextStyle() {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      letterSpacing: .25,
      height: 1.448,
    );
  }

  EdgeInsets buttonEdgeInsets() {
    return const EdgeInsets.only(
      top: 23,
      bottom: 14,
      left: 40,
      right: 40,
    );
  }

  TextStyle titleTextStyle() {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 13,
      letterSpacing: .25,
      height: 1.447,
      color: Color(0xff686868),
    );
  }

  EdgeInsets titleEdgeInsets() {
    return const EdgeInsets.only(
      top: 30,
      bottom: 10,
      left: 40,
      right: 40,
    );
  }
}
