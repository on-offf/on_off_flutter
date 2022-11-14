import 'package:carousel_slider/carousel_slider.dart';
import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:on_off/domain/entity/off/off_icon_entity.dart';
import 'package:on_off/domain/entity/off/off_image.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/domain/use_case/data_source/off/off_diary_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_icon_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_image_use_case.dart';
import 'package:on_off/ui/off/daily/off_daily_event.dart';
import 'package:on_off/ui/off/daily/off_daily_state.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:on_off/util/date_util.dart';

class OffDailyViewModel extends UiProviderObserve {
  OffDailyState _state = OffDailyState(
    currentIndex: 0,
    carouselController: CarouselController(),
  );

  final OffIconUseCase offIconUseCase;
  final OffDiaryUseCase offDiaryUseCase;
  final OffImageUseCase offImageUseCase;

  OffDailyViewModel({
    required this.offIconUseCase,
    required this.offDiaryUseCase,
    required this.offImageUseCase,
  });

  OffDailyState get state => _state;

  Future<void> onEvent(OffDailyEvent event) {
    event.when(
      changeCurrentIndex: _changeCurrentIndex,
      addIcon: _addIcon,
      changeDay: _changeDay,
    );
    return Future.value();
  }

  //이전 게시글로 이동하는거면 isBefore를 true, 다음 게시글은 false
  void _changeDay(bool isBefore) async {
    OffDiary? offDiary = await offDiaryUseCase.selectOffDiaryByUnixTimeLimit(
        state.content!.time, isBefore);
    if (offDiary == null) return;

    List<OffImage> imageList =
        await offImageUseCase.selectOffImageList(offDiary.id!);

    Content content = Content(
      id: offDiary.id,
      time: unixToDateTime(offDiary.dateTime),
      imageList: imageList,
      content: offDiary.content,
    );

    _state = _state.copyWith(content: content);
  }

  //Ui state에서 focused day가 변경되면 update 함수에 의해 실행됨.
  void _changedByFocusedDay(DateTime focusedDay) async {
    OffDiary? offDiary = await offDiaryUseCase.selectByDateTime(focusedDay);

    print("널체크 전");
    if (offDiary != null) {
      print("널체크 시작");
      List<OffImage> imageList =
          await offImageUseCase.selectOffImageList(offDiary.id!);

      Content content = Content(
        id: offDiary.id,
        time:
            unixToDateTime(offDiary.dateTime), //데이터에는 int 타입이라서 datetime으로 형변환
        imageList: imageList,
        content: offDiary.content,
      );

      _state = _state.copyWith(content: content);

      print("state 변경완료");
    } else {
      _state = _state.copyWith(content: null);
    }

    OffIconEntity? icon = await offIconUseCase.selectOffIcon(focusedDay);
    _state = _state.copyWith(icon: icon);

    notifyListeners();
  }

  void _addIcon(DateTime selectedDate, String path) async {
    selectedDate =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 9);
    var offIcon = await offIconUseCase.insert(selectedDate, path);

    _state = _state.copyWith(icon: offIcon);
    notifyListeners();
  }

  void _changeCurrentIndex(int currentIndex) {
    _state = _state.copyWith(currentIndex: currentIndex);
    notifyListeners();
  }

  @override
  init(UiState uiState) {
    this.uiState = uiState.copyWith();
  }

  //daily는 항상 list 스크린에서 focusedDay가 바뀐 후 호출되서 update만 됨.
  @override
  update(UiState uiState) {
    if (this.uiState!.focusedDay != uiState.focusedDay) {
      _changedByFocusedDay(uiState.focusedDay);
      print("_changedByFocusedDay 호출됨");
    }

    this.uiState = uiState.copyWith();
  }
}
