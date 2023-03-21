import 'package:flutter/material.dart';
import 'package:on_off/ui/on/monthly/on_monthly_view_model.dart';
import 'package:provider/provider.dart';

class OnMultiDeleteContainer extends StatelessWidget {
  const OnMultiDeleteContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnMonthlyViewModel viewModel = context.watch<OnMonthlyViewModel>();

    return SizedBox(
      height: 142,
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
                color: Colors.grey[500],
              ),
              child: const Text('취소'),
            ),
          ),
          const SizedBox(width: 9),
          GestureDetector(
            onTap: () {
              viewModel.deleteMultiOnTodo();
            },
            child: Container(
              height: 69,
              width: 153,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[500],
              ),
              child: const Text('전체 삭제'),
            ),
          ),
        ],
      ),
    );
  }
}
