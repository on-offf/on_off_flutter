import 'package:flutter/material.dart';
import 'package:on_off/ui/on/monthly/on_monthly_view_model.dart';
import 'package:provider/provider.dart';

class OnMultiDeleteContainer extends StatelessWidget {
  const OnMultiDeleteContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnMonthlyViewModel viewModel = context.watch<OnMonthlyViewModel>();

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              viewModel.updateMultiDeleteStatus();
            },
            child: Container(
              height: 40,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[500],
              ),
              child: const Text('취소'),
            ),
          ),
          GestureDetector(
            onTap: () {
              viewModel.deleteMultiOnTodo();
            },
            child: Container(
              height: 40,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[500],
              ),
              child: const Text('전체 삭제'),
            ),
          ),
        ],
      );
  }
}
