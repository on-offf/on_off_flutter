import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:on_off/domain/entity/on/on_todo.dart';
import 'package:on_off/ui/on/monthly/components/todo/on_todo_component.dart';
import 'package:on_off/ui/on/monthly/on_monthly_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class OnTodoComponents extends StatelessWidget {
  OnTodoComponents({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  OnMonthlyViewModel viewModel = context.watch<OnMonthlyViewModel>();
  UiProvider uiProvider = context.watch<UiProvider>();

    viewModel.generateTodoComponentsState();
    viewModel.state.todoComponentsController!.addListener(() {
      if (uiProvider.state.calendarFormat == CalendarFormat.week) {
        if (viewModel.state.todoComponentsController!.position.pixels <
            -60) {
          viewModel.unFocus();
          uiProvider.changeCalendarFormat(CalendarFormat.month);
        }
      } else {
        if (viewModel.state.todoComponentsController!.position.pixels - 60 >
            viewModel.state.todoComponentsController!.position.maxScrollExtent) {
          viewModel.unFocus();
          uiProvider.changeCalendarFormat(CalendarFormat.week);
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox = (key as GlobalKey).currentContext?.findRenderObject() as RenderBox;

      double displayHeight = MediaQuery.of(context).size.height;
      double y = renderBox.localToGlobal(Offset.zero).dy;

      double todoComponentsHeight = displayHeight - y;
      if (viewModel.state.multiDeleteStatus) {
        todoComponentsHeight -= 142;
      }
      viewModel.updateTodoComponentsHeight(todoComponentsHeight);
    });

    return Container(
      key: viewModel.state.todoComponentsKey,
      height: viewModel.state.todoComponentsHeight,
      child: SlidableAutoCloseBehavior(
        child: ReorderableListView.builder(
          scrollController: viewModel.state.todoComponentsController,
          buildDefaultDragHandles: viewModel.state.order == 'todoOrder',
          itemBuilder: (context, index) {
            OnTodo todo = viewModel.state.todos![index];
            return OnTodoComponent(key: ObjectKey(todo.id), onTodo: todo);
          },
          itemCount: viewModel.state.todos!.length,
          onReorder: (oldIndex, newIndex) async {
            List<OnTodo> copyTodos = [];
            int i = 0;
            for (int index = 0; index < viewModel.state.todos!.length; index++) {
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
      ),
    );
  }
}
