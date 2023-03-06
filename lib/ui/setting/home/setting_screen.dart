import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/domain/model/alert_time.dart';
import 'package:on_off/ui/components/simple_dialog.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:on_off/ui/setting/home/components/alert_time_dialog.dart';
import 'package:on_off/ui/setting/home/components/animated_switch.dart';
import 'package:on_off/ui/setting/password/password_confirm_screen.dart';
import 'package:on_off/ui/setting/home/setting_view_model.dart';
import 'package:provider/provider.dart';

import 'components/notification.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = '/setting/home';

  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    initNotification();
  }

  @override
  Widget build(BuildContext context) {
    final uiProvider = context.watch<UiProvider>();
    final viewModel = context.watch<SettingViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: uiProvider.state.colorConst.getPrimary(),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            IconPath.appbarPreviousButton.name,
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
            color: const Color(0xffebebeb),
            padding: titleEdgeInsets(),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '설정',
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
                    AnimatedSwitch(
                      uiState: uiProvider.state,
                      isLock: viewModel.state.setting.isScreenLock == 1,
                      onPressed: () async {
                        if (viewModel.state.setting.isScreenLock == 0 &&
                            viewModel.state.setting.password == null) {
                          bool initPassword = await _initPassword(
                              context,
                              viewModel,
                              uiProvider.state.colorConst.getPrimary());

                          if (!initPassword) return;
                        }
                        await viewModel.changeIsScreenLock();
                      },
                    ),
                  ],
                ),
                if (viewModel.state.setting.isScreenLock == 1)
                  Align(
                    alignment: Alignment.centerLeft,
                    heightFactor: .5,
                    child: TextButton(
                      onPressed: () async {
                        String? password = await _changePassword(
                          context: context,
                          primaryColor:
                              uiProvider.state.colorConst.getPrimary(),
                        );

                        if (password == null) return;

                        viewModel.changePassword(password);

                        simpleTextDialog(
                          context,
                          primaryColor: uiProvider.state.colorConst.getPrimary(),
                          canvasColor: Colors.white,
                          message: "비밀번호가 변경되었습니다.",
                        );
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
                    AnimatedSwitch(
                      uiState: uiProvider.state,
                      isLock: viewModel.state.setting.isAlert == 1,
                      onPressed: () async {
                        if (viewModel.state.setting.isAlert == 0 &&
                            viewModel.state.setting.alertHour == null) {
                          AlertTime? alertTime = await alertTimeDialog(
                            context,
                            viewModel,
                            viewModel.state,
                            uiProvider,
                            uiProvider.state,
                            uiProvider.state.colorConst.getPrimary(),
                          ) as AlertTime?;

                          if (alertTime == null) {
                            simpleTextDialog(
                              context,
                              primaryColor:
                                  uiProvider.state.colorConst.getPrimary(),
                              canvasColor: Colors.white,
                              message: '시간을 선택해주세요.',
                            );
                            return;
                          }
                          await viewModel.changeAlertTime(alertTime);
                        }
                        viewModel.changeIsAlert();
                      },
                    ),
                  ],
                ),
                if (viewModel.state.setting.isAlert == 1)
                  Container(
                    padding: const EdgeInsets.only(
                      top: 0,
                      bottom: 0,
                      left: 10,
                      right: 0,
                    ),
                    height: 20,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () async {
                          AlertTime? time = await alertTimeDialog(
                            context,
                            viewModel,
                            viewModel.state,
                            uiProvider,
                            uiProvider.state,
                            uiProvider.state.colorConst.getPrimary(),
                          );
                          if (time != null) {
                            viewModel.changeAlertTime(time);
                          }
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: messageTextStyle(),
                            children: [
                              const TextSpan(text: '매일 '),
                              TextSpan(
                                text: viewModel.state.setting.alertHour! < 12
                                    ? 'AM '
                                    : 'PM ',
                                style: messageTextStyle().copyWith(
                                  color:
                                      uiProvider.state.colorConst.getPrimary(),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: viewModel.state.setting.alertHour! == 0
                                    ? '12'
                                    : viewModel.state.setting.alertHour! <= 12
                                        ? '${viewModel.state.setting.alertHour!}'
                                        : '${viewModel.state.setting.alertHour! - 12}',
                                style: messageTextStyle().copyWith(
                                  color:
                                      uiProvider.state.colorConst.getPrimary(),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: ':',
                                style: messageTextStyle().copyWith(
                                  color:
                                      uiProvider.state.colorConst.getPrimary(),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${viewModel.state.setting.alertMinutes! < 10 ? '0' : ''}${viewModel.state.setting.alertMinutes!}',
                                style: messageTextStyle().copyWith(
                                  color:
                                      uiProvider.state.colorConst.getPrimary(),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const TextSpan(text: ' 에 나의 일상을 기록해보세요.'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                if (viewModel.state.setting.isAlert == 1)
                  const SizedBox(
                    height: 10,
                  ),
                if (viewModel.state.setting.isAlert == 1)
                  GestureDetector(
                    onTap: () async {
                      String? message = await simpleInputDialog(
                        context,
                        primaryColor: uiProvider.state.colorConst.getPrimary(),
                        canvasColor: uiProvider.state.colorConst.canvas,
                        width: 215,
                        height: 150,
                        message: "알림 메시지 내용을 입력해주세요!",
                        initMessage: viewModel.state.setting.alertMessage,
                      ) as String?;

                      if (message != null) {
                        viewModel.changeAlertMessage(message);
                        simpleTextDialog(
                          context,
                          primaryColor:
                              uiProvider.state.colorConst.getPrimary(),
                          canvasColor: Colors.white,
                          message: "알림 메시지가 변경되었습니다.",
                        );
                      }
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
                          child: SvgPicture.asset(
                            width: 9,
                            height: 14,
                            IconPath.settingArrowButton.name,
                          ),
                        ),
                      ],
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
                      'ON 시간 설정',
                      style: buttonTextStyle(),
                    ),
                    AnimatedSwitch(
                      uiState: uiProvider.state,
                      isLock: viewModel.state.setting.isOnOffSwitch == 1,
                      onPressed: () async {
                        viewModel.changeIsOnOffSwitch();
                      },
                    ),
                  ],
                ),
                if (viewModel.state.setting.isOnOffSwitch == 1)
                  Container(
                    padding: const EdgeInsets.only(
                      top: 0,
                      bottom: 0,
                      left: 10,
                      right: 0,
                    ),
                    height: 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ON 시작",
                          style: switchOnOffTextStyle(),
                        ),
                        TextButton(
                          onPressed: () async {
                            AlertTime? time = await alertTimeDialog(
                              context,
                              viewModel,
                              viewModel.state,
                              uiProvider,
                              uiProvider.state,
                              uiProvider.state.colorConst.getPrimary(),
                            );
                            if (time != null) {
                              viewModel.changeSwitchTime(true, time);
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                          ),
                          child: RichText(
                            text: TextSpan(
                              style: switchOnOffTextStyle(),
                              children: [
                                TextSpan(
                                  text:
                                      viewModel.state.setting.switchStartHour <
                                              12
                                          ? 'AM '
                                          : 'PM ',
                                  style: messageTextStyle().copyWith(
                                    color: uiProvider.state.colorConst
                                        .getPrimary(),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: viewModel
                                              .state.setting.switchStartHour ==
                                          0
                                      ? '12'
                                      : viewModel.state.setting
                                                  .switchStartHour <=
                                              12
                                          ? '${viewModel.state.setting.switchStartHour}'
                                          : '${viewModel.state.setting.switchStartHour - 12}',
                                  style: messageTextStyle().copyWith(
                                    color: uiProvider.state.colorConst
                                        .getPrimary(),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: ':',
                                  style: messageTextStyle().copyWith(
                                    color: uiProvider.state.colorConst
                                        .getPrimary(),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${viewModel.state.setting.switchStartMinutes < 10 ? '0' : ''}${viewModel.state.setting.switchStartMinutes}',
                                  style: messageTextStyle().copyWith(
                                    color: uiProvider.state.colorConst
                                        .getPrimary(),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (viewModel.state.setting.isOnOffSwitch == 1)
                  const SizedBox(
                    height: 10,
                  ),
                if (viewModel.state.setting.isOnOffSwitch == 1)
                  Container(
                    padding: const EdgeInsets.only(
                      top: 0,
                      bottom: 0,
                      left: 10,
                      right: 0,
                    ),
                    height: 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ON 종료",
                          style: switchOnOffTextStyle(),
                        ),
                        TextButton(
                          onPressed: () async {
                            AlertTime? time = await alertTimeDialog(
                              context,
                              viewModel,
                              viewModel.state,
                              uiProvider,
                              uiProvider.state,
                              uiProvider.state.colorConst.getPrimary(),
                            );
                            if (time != null) {
                              viewModel.changeSwitchTime(false, time);
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                          ),
                          child: RichText(
                            text: TextSpan(
                              style: switchOnOffTextStyle(),
                              children: [
                                TextSpan(
                                  text:
                                      viewModel.state.setting.switchEndHour < 12
                                          ? 'AM '
                                          : 'PM ',
                                  style: messageTextStyle().copyWith(
                                    color: uiProvider.state.colorConst
                                        .getPrimary(),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: viewModel.state.setting.switchEndHour ==
                                          0
                                      ? '12'
                                      : viewModel.state.setting.switchEndHour <=
                                              12
                                          ? '${viewModel.state.setting.switchEndHour}'
                                          : '${viewModel.state.setting.switchEndHour - 12}',
                                  style: messageTextStyle().copyWith(
                                    color: uiProvider.state.colorConst
                                        .getPrimary(),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: ':',
                                  style: messageTextStyle().copyWith(
                                    color: uiProvider.state.colorConst
                                        .getPrimary(),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${viewModel.state.setting.switchEndMinutes < 10 ? '0' : ''}${viewModel.state.setting.switchEndMinutes}',
                                  style: messageTextStyle().copyWith(
                                    color: uiProvider.state.colorConst
                                        .getPrimary(),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (viewModel.state.setting.isOnOffSwitch == 1)
                  const SizedBox(
                    height: 10,
                  ),
              ],
            ),
          ),
          Container(
            padding: titleEdgeInsets(),
            color: const Color(0xffebebeb),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '피드백',
                style: titleTextStyle(),
              ),
            ),
          ),
          // 2차 출시 이후에 반영.
          // GestureDetector(
          //   onTap: () {},
          //   child: Container(
          //     padding: buttonEdgeInsets(),
          //     color: Colors.white,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           '리뷰는 큰 힘이 됩니다!',
          //           style: buttonTextStyle(),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(right: 15.0),
          //           child: Image(
          //             width: 9,
          //             height: 14,
          //             image: AssetImage(
          //               IconPath.settingArrowButton.name,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // divide(),
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
                  GestureDetector(
                    onTap: () async => await _sendEmail(
                        context, uiProvider.state.colorConst.getPrimary()),
                    child: Text(
                      '아쉬운 점을 알려주세요!',
                      style: buttonTextStyle(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: SvgPicture.asset(
                      width: 9,
                      height: 14,
                      IconPath.settingArrowButton.name,
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
                  GestureDetector(
                    onTap: () => _showVersion(
                        context, uiProvider.state.colorConst.getPrimary()),
                    child: Text(
                      '버전관리',
                      style: buttonTextStyle(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: SvgPicture.asset(
                      width: 9,
                      height: 14,
                      IconPath.settingArrowButton.name,
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

  Future<String?> _changePassword({
    required BuildContext context,
    required Color primaryColor,
  }) async {
    String? firstPassword = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) =>
            PasswordConfirmScreen(title: '변경할 비밀번호를 입력해주세요.'),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    ) as String?;

    if (firstPassword == null) return null;

    String? secondPassword = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) =>
            PasswordConfirmScreen(title: '비밀번호를 다시 한번 확인해주세요.'),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    ) as String?;

    if (secondPassword == null) return null;

    if (firstPassword != secondPassword) {
      simpleTextDialog(
        context,
        primaryColor: primaryColor,
        canvasColor: Colors.white,
        message: "비밀번호가 일치하지 않습니다.",
      );
      return null;
    }
    return secondPassword;
  }

  Widget buttonWidget(SettingViewModel viewModel, UiState uiState, bool isLock,
      VoidCallback onPressed) {
    return SizedBox(
      width: 44,
      height: 22,
      child: ElevatedButton(
        onPressed: () => onPressed.call(),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 3,
          ),
          primary: isLock ? uiState.colorConst.getPrimary() : Colors.grey,
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

  TextStyle messageTextStyle() {
    return const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w100,
      letterSpacing: .25,
      height: 1.666,
      color: Colors.black,
    );
  }

  TextStyle switchOnOffTextStyle() {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w100,
      letterSpacing: .25,
      height: 1.666,
      color: Colors.black,
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

  Future<bool> _initPassword(BuildContext context, SettingViewModel viewModel,
      Color primaryColor) async {
    String? password = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) =>
            PasswordConfirmScreen(title: '비밀번호를 입력해주세요.'),
      ),
    ) as String?;

    if (password == null) {
      simpleTextDialog(
        context,
        primaryColor: primaryColor,
        canvasColor: Colors.white,
        message: '변경할 비밀번호를 입력해주세요.',
      );
      return false;
    }

    String? secondPassword = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) =>
            PasswordConfirmScreen(title: '비밀번호를 확인해주세요.'),
      ),
    ) as String?;

    if (secondPassword == null) {
      simpleTextDialog(context,
          primaryColor: primaryColor,
          canvasColor: Colors.white,
          message: '비밀번호를 다시 한번 확인해주세요.');
      return false;
    } else if (password != secondPassword) {
      simpleTextDialog(
        context,
        primaryColor: primaryColor,
        canvasColor: Colors.white,
        message: '비밀번호가 일치하지 않습니다.',
      );
      return false;
    }

    await viewModel.changePassword(password);
    return true;
  }

  _sendEmail(context, primaryColor) async {
    final Email email = Email(
      body: '',
      subject: '[ON & OFF 피드백입니다.]',
      recipients: ['bskim@hoogi.com'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      String message = "기본 메일 앱이 설정되어 있지 않습니다.\nbskim@hoogi.com으로 연락주세요.";

      simpleTextDialog(
        context,
        primaryColor: primaryColor,
        canvasColor: Colors.white,
        message: message,
      );
    }
  }

  void _showVersion(context, primaryColor) {
    String message = "현재 버전은 0.1 입니다.\n2023년 1월 v1.0 출시 예정입니다.";

    simpleTextDialog(
      context,
      primaryColor: primaryColor,
      canvasColor: Colors.white,
      message: message,
    );
  }
}
