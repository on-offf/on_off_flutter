// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:on_off/domain/use_case/data_source/on/on_todo_use_case.dart';
import 'package:on_off/ui/on/monthly/on_monthly_state.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';

import '../../../domain/entity/on/on_todo.dart';

class OnMonthlyViewModel extends UiProviderObserve {
  final OnTodoUseCase onTodoUseCase;

  OnMonthlyViewModel({
    required this.onTodoUseCase,
  });

  OnMonthlyState _state = OnMonthlyState();

  OnMonthlyState get state => _state;

  initScreen() async {
    changeFocusedDay(uiState!.focusedDay);
  }

  saveContent(String title) async {
    DateTime dateTime = uiState!.focusedDay;
    if (title != null) {
      await onTodoUseCase.insertOnTodo(dateTime, title);
      print("저장완료됨! 내용 : $title");
    }
    notifyListeners();
  }

  changeTodoStatus(OnTodo todo) {
    int status = todo.status;
    if (status == 0)
      status = 1;
    else
      status = 0;
    print("바뀌기 전 tood status : ${todo.status}");
    onTodoUseCase.updateTodoStatus(todo.copyWith(status: status));
    // print("바뀐후 tood status : ${todo.status}");
  }

  changeFocusedDay(DateTime focusedDay) async {
    _changeFocusedDay(focusedDay);
    notifyListeners();
  }

  _changeFocusedDay(DateTime focusedDay) async {
    // OnTodo? onTodo = await OnTodoUseCase.selectByDateTime(focusedDay);

    // if (offDiary != null) {
    //   List<OffImage> imageList =
    //       await offImageUseCase.selectOffImageList(offDiary.id!);

    //   Content content = Content(
    //     id: offDiary.id,
    //     time: unixToDateTime(offDiary.dateTime),
    //     title: offDiary.title,
    //     imageList: imageList,
    //     content: offDiary.content,
    //   );

    //   _state = _state.copyWith(content: content);
    // } else {
    //   _state = _state.copyWith(content: null);
    // }

    // OffIconEntity? icon = await offIconUseCase.selectOffIcon(focusedDay);
    // _state = _state.copyWith(icon: icon);
  }

  @override
  init(UiState uiState) async {
    this.uiState = uiState.copyWith();
    // _state = _state.copyWith(todos: DUMMY_TODOS);
    // await _changeFocusedDay(uiState.focusedDay);
  }

  @override
  update(UiState uiState) async {
    // if (this.uiState!.focusedDay != uiState.focusedDay) {
    //   await changeFocusedDay(uiState.focusedDay);
    // }
    this.uiState = uiState.copyWith();
  }
}

// List<OnTodo> DUMMY_TODOS = [
//   OnTodo(
//     dateTime: 20230125,
//     title: "제목제목제목1",
//     content: "내용내용내용내용내용내용내용내용내용내용내용내용1",
//     status: 1,
//   ),
//   OnTodo(
//     dateTime: 20230125,
//     title: "제목제목제목2",
//     content: "내용내용내용내용내용내용내용내용내용내용내용내용2",
//     status: 0,
//   ),
//   OnTodo(
//     dateTime: 20230125,
//     title: "제목제목제목3",
//     content: "내용내용내용내용내용내용내용내용내용내용내용내용3",
//     status: 1,
//   ),
// ];
