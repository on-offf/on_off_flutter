import 'package:flutter/material.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/on/monthly/on_monthly_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

import '../../../components/simple_dialog.dart';

class OnMultiDeleteContainer extends StatelessWidget {
  const OnMultiDeleteContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = context.watch<UiProvider>();
    OnMonthlyViewModel viewModel = context.watch<OnMonthlyViewModel>();

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(25),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        decoration: BoxDecoration(
          color: uiProvider.state.colorConst.getPrimary(),
        ),
        padding: const EdgeInsets.only(
          top: 1,
        ),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
              color: Colors.white),
          child: Container(
            height: 142,
            padding: const EdgeInsets.only(
              top: 21,
              bottom: 52,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
              color: uiProvider.state.colorConst.getPrimary().withOpacity(.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    viewModel.updateMultiDeleteStatus();
                  },
                  child: Container(
                    height: 69,
                    width: 153,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: uiProvider.state.colorConst.getPrimary(),
                        width: 1,
                      ),
                      color: Colors.white,
                    ),
                    child: Text(
                      '뒤로가기',
                      style: kBody2.copyWith(
                        color: uiProvider.state.colorConst.getPrimary(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 9),
                GestureDetector(
                  onTap: () async {
                    bool result = await simpleConfirmButtonDialog(
                      context,
                      primaryColor: uiProvider.state.colorConst.getPrimary(),
                      canvasColor: uiProvider.state.colorConst.canvas,
                      message: "선택한 일정을 \n진짜로 삭제하시겠습니까?",
                      trueButton: "네",
                      falseButton: "뒤로가기",
                      width: 215,
                      height: 134,
                    );
                    if (result) viewModel.deleteMultiOnTodo();
                  },
                  child: Container(
                    height: 69,
                    width: 153,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: uiProvider.state.colorConst.getPrimary(),
                        width: 1,
                      ),
                      color: Colors.white,
                    ),
                    child: Text(
                      '선택한 일정 삭제하기',
                      style: kBody2.copyWith(
                        color: uiProvider.state.colorConst.getPrimary(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
