import 'package:flutter/material.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:on_off/ui/setting/password/password_confirm_screen.dart';
import 'package:on_off/ui/setting/home/setting_event.dart';
import 'package:on_off/ui/setting/home/setting_view_model.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/setting/home';

  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = context.watch<UiProvider>();
    final uiState = uiProvider.state;
    final viewModel = context.watch<SettingViewModel>();
    final state = viewModel.state;

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
        physics: const NeverScrollableScrollPhysics(),
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '화면잠금',
                      style: buttonTextStyle(),
                    ),
                    buttonWidget(
                      viewModel,
                      uiState,
                      state.setting.isScreenLock == 1,
                      const SettingEvent.changeIsScreenLock(),
                    ),
                  ],
                ),
                if (state.setting.isScreenLock == 1)
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () async {
                      String? password = await Navigator.pushNamed(context, PasswordConfirmScreen.routeName) as String?;

                      if (password != null) {
                        viewModel.onEvent(SettingEvent.changePassword(password));
                      }
                    },
                    child: Text(
                      '비밀번호 변경',
                      style: kBody1.copyWith(
                        color: const Color(0xffff0000),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          divide(),
          Container(
            padding: buttonEdgeInsets(),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '알림',
                      style: buttonTextStyle(),
                    ),
                    buttonWidget(
                      viewModel,
                      uiState,
                      state.setting.isAlert == 1,
                      const SettingEvent.changeIsAlert(),
                    ),
                  ],
                ),
                if (state.setting.isAlert == 1)
                  const SizedBox(
                    height: 10,
                  ),
                if (state.setting.isAlert == 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      const Text(
                        '시간',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w100,
                            letterSpacing: .25,
                            height: 1.666),
                      ),
                      Text(
                        'PM 10:00',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w100,
                            letterSpacing: .25,
                            height: 1.666),
                      ),
                    ],
                  ),
                if (state.setting.isAlert == 1)
                  const SizedBox(
                    height: 10,
                  ),
                if (state.setting.isAlert == 1)
                  GestureDetector(
                    onTap: () {
                      print('click!!!');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '메시지 설정',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w100,
                              letterSpacing: .25,
                              height: 1.666),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Image(
                            width: 9,
                            height: 14,
                            image: AssetImage(
                              IconPath.settingArrowButton.name,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
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
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: buttonEdgeInsets(),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '리뷰는 큰 힘이 됩니다!',
                    style: buttonTextStyle(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Image(
                      width: 9,
                      height: 14,
                      image: AssetImage(
                        IconPath.settingArrowButton.name,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          divide(),
          GestureDetector(
            onTap: () {
              print('click!');
            },
            child: Container(
              padding: buttonEdgeInsets(),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '아쉬운 점을 알려주세요!',
                    style: buttonTextStyle(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Image(
                      width: 9,
                      height: 14,
                      image: AssetImage(
                        IconPath.settingArrowButton.name,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          divide(),
          GestureDetector(
            onTap: () {
              print('click!!');
            },
            child: Container(
              padding: buttonEdgeInsets(),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '버전관리',
                    style: buttonTextStyle(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Image(
                      width: 9,
                      height: 14,
                      image: AssetImage(
                        IconPath.settingArrowButton.name,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          divide(),
          Container(
            color: Colors.white,
            height: 100,
          ),
        ],
      ),
    );
  }

  Widget buttonWidget(SettingViewModel viewModel, UiState uiState, bool isLock,
      SettingEvent event) {
    return SizedBox(
      width: 44,
      height: 22,
      child: ElevatedButton(
        onPressed: () {
          viewModel.onEvent(event);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 3,
          ),
          backgroundColor:
              isLock ? uiState.colorConst.getPrimary() : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: AnimatedAlign(
          alignment: isLock ? Alignment.centerRight : Alignment.centerLeft,
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: 23,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
          ),
        ),
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
      bottom: 10,
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
