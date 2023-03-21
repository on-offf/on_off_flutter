import 'package:flutter/material.dart';
import 'package:on_off/domain/entity/on/on_todo.dart';
import 'package:on_off/domain/model/OnTodoStatus.dart';
import 'package:on_off/domain/use_case/data_source/on/on_todo_use_case.dart';
import 'package:on_off/ui/on/monthly/on_monthly_state.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';

class OnMonthlyViewModel extends UiProviderObserve {
  final OnTodoUseCase onTodoUseCase;

  OnMonthlyViewModel({
    required this.onTodoUseCase,
  });

  OnMonthlyState _state = OnMonthlyState(
      order: 'id',
      multiDeleteStatus: false,
      multiDeleteTodoIds: {},
      showStatus: 2,
      todos: [],
      keyboardHeight: 0,
      todoComponentsHeight: 500);

  OnMonthlyState get state => _state;

  initScreen() async {
    await changeFocusedDay(uiState!.focusedDay);
  }

  generateMonthlyScreenScrollerController() {
    _state =
        _state.copyWith(onMonthlyScreenScrollerController: ScrollController());
  }

  generateTodoComponentsState() {
    _state = _state.copyWith(
      todoComponentsController: ScrollController(),
      todoComponentsKey: GlobalKey(),
    );
  }

  generateTodoInputState(FocusNode focusNode) {
    _state = _state.copyWith(
      todoInputFocusNode: focusNode,
    );
  }

  updateTodoComponentsHeight(double height) {
    if (_state.todoComponentsHeight == height) return;
    _state = _state.copyWith(todoComponentsHeight: height);
    notifyListeners();
  }

  unFocus() {
    if (state.todoInputFocusNode != null && state.todoInputFocusNode!.hasFocus) {
      state.todoInputFocusNode!.unfocus();
    }

    if (state.multiDeleteStatus) {
      _state = _state.copyWith(multiDeleteStatus: false);
      notifyListeners();
    }
  }

  saveContent(String title) async {
    if (title.trim().isEmpty) return;

    DateTime dateTime = uiState!.focusedDay;
    OnTodo todo = await onTodoUseCase.insertOnTodo(dateTime, title);

    List<OnTodo> todos = [];
    todos.add(todo);
    for (var element in _state.todos!) {
      todos.add(element);
    }

    _state = _state.copyWith(todos: todos);
    notifyListeners();
  }

  changeTodoStatus(OnTodo todo) {
    int status = todo.status;

    if (status == 0) {
      status = 1;
    } else {
      status = 0;
    }

    onTodoUseCase.updateTodoStatus(todo.copyWith(status: status));
    List<OnTodo> todos = [];
    state.todos?.forEach((element) {
      if (element.id == todo.id) {
        element = element.copyWith(status: status);
      }

      if (state.showStatus == 2 || state.showStatus == element.status) {
        todos.add(element);
      }
    });

    _state = _state.copyWith(todos: todos);
  }

  changeTodosByStatus(int status) async {
    int? changeStatus = status;
    if (status == ALL) {
      changeStatus = null;
    }

    List<OnTodo> selectOnTodos = await onTodoUseCase.selectOnTodoList(
      uiState!.focusedDay,
      state.order,
      changeStatus,
    );
    _state = _state.copyWith(todos: selectOnTodos, showStatus: status);
    notifyListeners();
  }

  deleteTodo(OnTodo todo) async {
    await onTodoUseCase.deleteOnTodo(todo);
    List<OnTodo> todos = [];
    state.todos?.forEach((element) {
      if (element.id == todo.id) {
      } else {
        todos.add(element);
      }
    });
    _state = _state.copyWith(todos: todos);
    notifyListeners();
  }

  deleteMultiOnTodo() async {
    List<OnTodo> deleteTodos = [];
    List<OnTodo> restTodos = [];
    _state.todos?.forEach((todo) {
      if (_state.multiDeleteTodoIds.containsKey(todo.id!)) {
        deleteTodos.add(todo);
      } else {
        restTodos.add(todo);
      }
    });

    await onTodoUseCase.deleteMultiOnTodo(deleteTodos);
    _state = _state.copyWith(
        todos: restTodos, multiDeleteStatus: false, multiDeleteTodoIds: {});
    notifyListeners();
  }

  updateTodos(List<OnTodo> todos) async {
    _state = _state.copyWith(todos: todos);
    notifyListeners();
    onTodoUseCase.updateTodoList(todos);
  }

  changeFocusedDay(DateTime focusedDay) async {
    await _changeFocusedDay(focusedDay);
  }

  updateMultiDeleteStatus() {
    _state = _state.copyWith(
        multiDeleteStatus: !_state.multiDeleteStatus, multiDeleteTodoIds: {});
    notifyListeners();
  }

  updateMultiDeleteTodoIdCheck(int id, bool checked) {
    Map<int, bool> multiDeleteTodoIds = Map.from(_state.multiDeleteTodoIds);

    multiDeleteTodoIds.putIfAbsent(id, () => checked);
    if (!checked) {
      multiDeleteTodoIds.remove(id);
    }

    _state = _state.copyWith(multiDeleteTodoIds: multiDeleteTodoIds);
  }

  updateKeyboardHeight(double keyboardHeight) {
    _state.onMonthlyScreenScrollerController!.animateTo(
      0,
      duration: const Duration(milliseconds: 450),
      curve: Curves.ease,
    );
    _state = _state.copyWith(keyboardHeight: keyboardHeight);
    notifyListeners();
  }

  _changeFocusedDay(DateTime focusedDay) async {
    unFocus();
    List<OnTodo> selectOnTodoList = await onTodoUseCase.selectOnTodoList(
      focusedDay,
      state.order,
      null,
    );
    _state = _state.copyWith(todos: selectOnTodoList, showStatus: 2);
  }

  @override
  init(UiState uiState) async {
    this.uiState = uiState.copyWith();
    await _changeFocusedDay(uiState.focusedDay);
  }

  @override
  update(UiState uiState) async {
    if (this.uiState!.focusedDay != uiState.focusedDay) {
      await _changeFocusedDay(uiState.focusedDay);
    }
    this.uiState = uiState.copyWith();
  }
}
