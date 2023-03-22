import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/entity/on/on_todo.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/on/monthly/on_monthly_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class OnTodoComponent extends StatefulWidget {
  const OnTodoComponent({Key? key, required this.onTodo}) : super(key: key);
  final OnTodo onTodo;

  @override
  State<OnTodoComponent> createState() => _OnTodoComponentState();
}

class _OnTodoComponentState extends State<OnTodoComponent> {
  bool? deleteChecked = false;
  late OnTodo todo = widget.onTodo.copyWith();

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
              value: deleteChecked,
              checkColor: Colors.transparent,
              fillColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return uiProvider.state.colorConst.getPrimary();
                }
                return const Color.fromRGBO(0, 0, 0, .23);
              }),
              shape: const CircleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.transparent,
                ),
              ),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              onChanged: (isChecked) async {
                setState(() => deleteChecked = isChecked);
                viewModel.updateMultiDeleteTodoIdCheck(todo.id!, isChecked!);
              },
            ),
          Expanded(
            child: Slidable(
              groupTag: 0,
              endActionPane: viewModel.state.multiDeleteStatus
                  ? null
                  : ActionPane(
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
                  if (!viewModel.state.multiDeleteStatus)
                    Checkbox(
                      value: todo.status == 1 ? true : false,
                      onChanged: (bool? value) {
                        viewModel.changeTodoStatus(widget.onTodo);
                        setState(() {
                          todo = todo.copyWith(status: value! ? 1 : 0);
                        });

                        if (viewModel.state.showStatus != 2) {
                          viewModel.notifyListeners();
                        }
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
