// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:on_off/ui/components/simple_dialog.dart';
import 'package:provider/provider.dart';

import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/provider/ui_provider.dart';

class PasswordConfirmScreen extends StatefulWidget {
  static const routeName = '/setting/password/confirm';
  late String title;
  String? realPassword;
  Function? passwordIsNotDialog;

  PasswordConfirmScreen({
    Key? key,
    required this.title,
    this.realPassword,
  }) : super(key: key);

  @override
  State<PasswordConfirmScreen> createState() => _PasswordConfirmScreenState();
}

class _PasswordConfirmScreenState extends State<PasswordConfirmScreen> {
  String _password = '';
  List<String> keypadList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "cancel",
    "0",
    "Delete",
  ];

  @override
  Widget build(BuildContext context) {
    final uiProvider = context.watch<UiProvider>();
    final uiState = uiProvider.state;
    String title = widget.title;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: uiState.colorConst.getPrimary(),
        elevation: 0,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: uiState.colorConst.getPrimary(),
              elevation: 0,
            ),
            child: const Icon(
              Icons.close,
            ),
          ),
        ],
        leading: Container(),
        centerTitle: true,
        title: const Text(
          '설정',
          style: kBody2,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 67,
          left: 30,
          right: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: kBody2.copyWith(
                color: uiState.colorConst.getPrimary(),
              ),
            ),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                passwordWidget(
                  _password.isNotEmpty,
                  uiState.colorConst.getPrimary(),
                ),
                const SizedBox(width: 27),
                passwordWidget(
                  _password.length > 1,
                  uiState.colorConst.getPrimary(),
                ),
                const SizedBox(width: 27),
                passwordWidget(
                  _password.length > 2,
                  uiState.colorConst.getPrimary(),
                ),
                const SizedBox(width: 27),
                passwordWidget(
                  _password.length > 3,
                  uiState.colorConst.getPrimary(),
                ),
              ],
            ),
            SizedBox(
              height: 550,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: keypadList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1 / 1,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                ),
                itemBuilder: (ctx, idx) {
                  return Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        if ((0 <= idx && idx <= 8 || idx == 10) &&
                            _password.length < 4) {
                          _password = _password + keypadList[idx];
                        } else if (idx == 9) {
                          Navigator.pop(context);
                        } else if (idx == 11 && _password.isNotEmpty) {
                          _password = _password.replaceRange(
                              _password.length - 1, _password.length, '');
                        }

                        if (_password.length == 4) {
                          if (widget.realPassword != null &&
                              widget.realPassword != _password) {
                            _password = "";
                            simpleTextDialog(
                              context,
                              primaryColor:
                                  uiProvider.state.colorConst.getPrimary(),
                              canvasColor: uiProvider.state.colorConst.canvas,
                              message: '비밀번호가 일치하지 않습니다.',
                            );
                          }
                          Navigator.pop(context, _password);
                        }
                        setState(() {});
                      },
                      style: OutlinedButton.styleFrom(
                        primary: uiState.colorConst.getPrimary(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        keypadList[idx],
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                          height: 1.6,
                          color: uiState.colorConst.getPrimary(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget passwordWidget(bool isComplete, Color primaryColor) {
    return Container(
      width: 27,
      height: 27,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: isComplete ? primaryColor : Colors.transparent,
        border: isComplete
            ? const Border()
            : Border.all(
                width: 1,
                color: primaryColor,
              ),
      ),
    );
  }
}
