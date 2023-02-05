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
  }

  changeFocusedDay(DateTime focusedDay) async {
    await _changeFocusedDay(focusedDay);
  }

  _changeFocusedDay(DateTime focusedDay) async {
    List<OnTodo> selectOnTodoList = await onTodoUseCase.selectOnTodoList(
      focusedDay,
      'id',
      0,
    );
    print(selectOnTodoList);
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
