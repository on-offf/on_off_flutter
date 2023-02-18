import 'package:on_off/domain/entity/on/on_todo.dart';
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
    todos: [],
  );

  OnMonthlyState get state => _state;

  initScreen() async {
    changeFocusedDay(uiState!.focusedDay);
  }

  saveContent(String title) async {
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
        todos.add(element);
      } else {
        todos.add(element);
      }
    });

    _state = _state.copyWith(todos: todos);
    notifyListeners();
  }

  changeTodosByStatus(int? status) async {
    List<OnTodo> selectOnTodos = await onTodoUseCase.selectOnTodoList(
      uiState!.focusedDay,
      state.order,
      status,
    );
    _state = _state.copyWith(todos: selectOnTodos);
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
    _state = _state.copyWith(todos: restTodos, multiDeleteStatus: false, multiDeleteTodoIds: {});
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
    notifyListeners();
  }

  _changeFocusedDay(DateTime focusedDay) async {
    List<OnTodo> selectOnTodoList = await onTodoUseCase.selectOnTodoList(
      focusedDay,
      state.order,
      null,
    );
    _state = _state.copyWith(todos: selectOnTodoList);
  }

  @override
  init(UiState uiState) async {
    this.uiState = uiState.copyWith();
  }

  @override
  update(UiState uiState) async {
    if (this.uiState!.focusedDay != uiState.focusedDay) {
      await _changeFocusedDay(uiState.focusedDay);
    }
    this.uiState = uiState.copyWith();
  }
}
