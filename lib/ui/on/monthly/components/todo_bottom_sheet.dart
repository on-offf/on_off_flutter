import 'package:flutter/material.dart';
import 'package:on_off/domain/model/OnTodoStatus.dart';
import 'package:on_off/ui/on/monthly/on_monthly_view_model.dart';
import 'package:provider/provider.dart';

class TodoBottomSheetMenu extends StatelessWidget {
  const TodoBottomSheetMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnMonthlyViewModel viewModel = context.watch<OnMonthlyViewModel>();

    return Container(
      height: 400,
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                viewModel.changeTodosByStatus(INCOMPLETE);
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[500],
                ),
                child: const Text("미완료 일정 보기"),
              ),
            ),
            GestureDetector(
              onTap: () {
                viewModel.changeTodosByStatus(DONE);
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[500],
                ),
                child: const Text("완료 일정 보기"),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            viewModel.changeTodosByStatus(null);
            Navigator.pop(context);
          },
          child: Container(
            height: 50,
            width: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[500],
            ),
            child: const Text("오늘의 일정 전체보기"),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            viewModel.updateMultiDeleteStatus();
            Navigator.pop(context);
          },
          child: Container(
            height: 50,
            width: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[500],
            ),
            child: const Text("다수의 일정 삭제하기"),
          ),
        ),
      ]),
    );
  }

}
