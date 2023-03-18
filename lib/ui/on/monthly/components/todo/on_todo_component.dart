import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/entity/on/on_todo.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/on/monthly/on_monthly_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class OnTodoComponent extends StatelessWidget {
  const OnTodoComponent({Key? key, required this.todo}) : super(key: key);
  final OnTodo todo;

  @override
  Widget build(BuildContext context) {
    OnMonthlyViewModel viewModel = context.watch<OnMonthlyViewModel>();
    UiProvider uiProvider = context.watch<UiProvider>();

    return SizedBox(
      height: 40,
      child: Row(
        children: [
          if (viewModel.state.multiDeleteStatus)
            Checkbox(
              value:
              viewModel.state.multiDeleteTodoIds.containsKey(todo.id),
              onChanged: (isChecked) async {
                await viewModel.updateMultiDeleteTodoIdCheck(
                    todo.id!, isChecked!);
              },
              checkColor: const Color(0xffFFFFFF),
            ),
          Expanded(
            child: Slidable(
              groupTag: 0,
              endActionPane: ActionPane(
                extentRatio: .15,
                motion: const ScrollMotion(),
                children: [
                  IconButton(
                    onPressed: () async {
                      await viewModel.deleteTodo(todo);
                    },
                    icon: SvgPicture.asset(
                      width: 18,
                      height: 18,
                      IconPath.trashCan.name,
                    ),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: todo.status == 1 ? true : false,
                    onChanged: (bool? value) async {
                      await viewModel.changeTodoStatus(todo);
                    },
                    activeColor: uiProvider.state.colorConst.getPrimary(),
                    side: const BorderSide(
                      color: Color(0xffD9D9D9),
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Text(
                    todo.title,
                    style: todo.status == 1
                        ? kBody2.copyWith(
                      color: const Color(0xffb3b3b3),
                      decoration: TextDecoration.lineThrough,
                    )
                        : kBody2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
