import 'package:flutter/material.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/model/OnTodoStatus.dart';
import 'package:on_off/ui/on/monthly/on_monthly_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class TodoBottomSheetMenu extends StatelessWidget {
  const TodoBottomSheetMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnMonthlyViewModel viewModel = context.watch<OnMonthlyViewModel>();
    UiProvider uiProvider = context.watch<UiProvider>();

    return Container(
      height: 400,
      padding: const EdgeInsets.only(
        top: 43,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
        color: uiProvider.state.colorConst.getPrimary().withOpacity(.2),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  viewModel.changeTodosByStatus(INCOMPLETE);
                  Navigator.pop(context);
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
                    "미완료 일정 보기",
                    style: kBody2.copyWith(
                      color: uiProvider.state.colorConst.getPrimary(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 9,
              ),
              GestureDetector(
                onTap: () {
                  viewModel.changeTodosByStatus(DONE);
                  Navigator.pop(context);
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
                    "완료 일정 보기",
                    style: kBody2.copyWith(
                      color: uiProvider.state.colorConst.getPrimary(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              viewModel.changeTodosByStatus(ALL);
              Navigator.pop(context);
            },
            child: Container(
              height: 69,
              width: 313,
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
                "오늘의 일정 전체보기",
                style: kBody2.copyWith(
                  color: uiProvider.state.colorConst.getPrimary(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 13),
          GestureDetector(
            onTap: () {
              viewModel.updateMultiDeleteStatus();
              Navigator.pop(context);
            },
            child: Container(
              height: 69,
              width: 313,
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
                "다수의 일정 삭제하기",
                style: kBody2.copyWith(
                  color: uiProvider.state.colorConst.getPrimary(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
