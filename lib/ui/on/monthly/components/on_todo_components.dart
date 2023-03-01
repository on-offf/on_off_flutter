import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/entity/on/on_todo.dart';
import 'package:on_off/ui/on/monthly/components/on_todo_component.dart';
import 'package:on_off/ui/on/monthly/on_monthly_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class OnTodoComponents extends StatelessWidget {
  var createTodoTextFormFieldController = TextEditingController();

  OnTodoComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnMonthlyViewModel viewModel = context.watch<OnMonthlyViewModel>();
    UiProvider uiProvider = context.watch<UiProvider>();

    return Column(
      children: [
        const SizedBox(height: 15),
        DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(7),
          color: uiProvider.state.colorConst.getPrimary(),
          strokeWidth: 1,
          child: Container(
            height: 50,
            color: const Color(0xfff8f8f8),
            child: Row(
              children: [
                const SizedBox(
                  height: 50,
                  width: 40,
                ),
                Expanded(
                  child: TextFormField(
                    style: kSubtitle2.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    controller: createTodoTextFormFieldController,
                    decoration: InputDecoration(
                      hintText: "오늘의 리스트를 추가해 주세요!",
                      hintStyle:
                          kSubtitle2.copyWith(fontWeight: FontWeight.bold),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: uiProvider.state.colorConst.getPrimary(),
                        ),
                      ),
                    ),
                    onFieldSubmitted: (value) async {
                      await viewModel.saveContent(value);
                      createTodoTextFormFieldController.text = '';
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        FutureBuilder(
          future: viewModel.update(uiProvider.state),
          builder: (context, snapshot) {
            if (snapshot.connectionState.name == "done") {
              var box = context.findRenderObject() as RenderBox;
              Offset startPos = box.localToGlobal(Offset.zero);

              return SizedBox(
                height: viewModel.state.multiDeleteStatus
                    ? MediaQuery.of(context).size.height -
                    startPos.distance -
                    200
                    : MediaQuery.of(context).size.height -
                    startPos.distance -
                    170,
                child: ReorderableListView.builder(
                  buildDefaultDragHandles: viewModel.state.order == 'todoOrder',
                  itemBuilder: (context, index) {
                    OnTodo todo = viewModel.state.todos![index];
                    return OnTodoComponent(key: ObjectKey(todo.id), todo: todo);
                  },
                  itemCount: viewModel.state.todos!.length,
                  onReorder: (oldIndex, newIndex) async {
                    List<OnTodo> copyTodos = [];
                    int i = 0;
                    for (int index = 0;
                    index < viewModel.state.todos!.length;
                    index++) {
                      if (index == oldIndex) {
                        continue;
                      } else if (index == newIndex) {
                        OnTodo todo = viewModel.state.todos![oldIndex];
                        copyTodos.add(todo.copyWith(todoOrder: i++));
                      }

                      OnTodo todo = viewModel.state.todos![index];
                      copyTodos.add(todo.copyWith(todoOrder: i++));
                    }

                    if (newIndex == viewModel.state.todos!.length) {
                      OnTodo todo = viewModel.state.todos![oldIndex];
                      copyTodos.add(todo.copyWith(todoOrder: newIndex));
                    }
                    await viewModel.updateTodos(copyTodos);
                  },
                ),
              );
            }

            return Container();
          },
        ),
      ],
    );
  }
}
