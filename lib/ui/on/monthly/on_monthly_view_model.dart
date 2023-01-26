import 'package:on_off/ui/on/monthly/on_monthly_state.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';

import '../../../domain/entity/on/on_todo.dart';

class OnMonthlyViewModel extends UiProviderObserve {
  OnMonthlyState _state = OnMonthlyState();

  OnMonthlyState get state => _state;

  initScreen() async {
    changeFocusedDay(uiState!.focusedDay);
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
    _state = _state.copyWith(todos: DUMMY_TODOS);
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

List<OnTodo> DUMMY_TODOS = [
  OnTodo(
    dateTime: 20230125,
    title: "제목제목제목1",
    content: "내용내용내용내용내용내용내용내용내용내용내용내용1",
    status: 1,
  ),
  OnTodo(
    dateTime: 20230125,
    title: "제목제목제목2",
    content: "내용내용내용내용내용내용내용내용내용내용내용내용2",
    status: 0,
  ),
  OnTodo(
    dateTime: 20230125,
    title: "제목제목제목3",
    content: "내용내용내용내용내용내용내용내용내용내용내용내용3",
    status: 1,
  ),
];
