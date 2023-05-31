import 'package:carousel_slider/carousel_slider.dart';
import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:on_off/domain/entity/off/off_icon_entity.dart';
import 'package:on_off/domain/entity/off/off_image.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/domain/use_case/data_source/off/off_diary_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_icon_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_image_use_case.dart';
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

  initScreen() async {
    await _changedByFocusedDay(uiState!.focusedDay);
  }

  void changeDay(bool isBefore) async {
    OffDiary? offDiary = await offDiaryUseCase.selectOffDiaryByUnixTimeLimit(
        state.content!.time, isBefore);
    if (offDiary == null) return;

    List<OffImage> imageList =
        await offImageUseCase.selectOffImageList(offDiary.id!);

    Content content = Content(
      id: offDiary.id,
      title: offDiary.title,
      time: unixToDateTime(offDiary.dateTime),
      imageList: imageList,
      content: offDiary.content,
    );

    _state = _state.copyWith(content: content);
  }

  _changedByFocusedDay(DateTime focusedDay) async {
    OffDiary? offDiary = await offDiaryUseCase.selectByDateTime(focusedDay);

    if (offDiary != null) {
      List<OffImage> imageList =
          await offImageUseCase.selectOffImageList(offDiary.id!);

      Content content = Content(
        id: offDiary.id,
        time: unixToDateTime(offDiary.dateTime), //데이터에는 int 타입이라서 datetime으로 형변환
        title: offDiary.title,
        imageList: imageList,
        content: offDiary.content,
      );

      _state = _state.copyWith(content: content);
    } else {
      _state = _state.copyWith(content: null);
    }

    OffIconEntity? icon = await offIconUseCase.selectOffIcon(focusedDay);
    _state = _state.copyWith(icon: icon);
  }

  addIcon(String path) async {
    OffIconEntity icon = await offIconUseCase.insert(uiState!.focusedDay, path);
    _state = _state.copyWith(icon: icon);
    notifyListeners();
  }

  void changeCurrentIndex(int currentIndex) {
    _state = _state.copyWith(currentIndex: currentIndex);
    notifyListeners();
  }

  void removeIcon(DateTime dateTime) async {
    await offIconUseCase.delete(dateTime);
    _state = _state.copyWith(icon: null);
    notifyListeners();
  }

  @override
  init(UiState uiState) async {
    this.uiState = uiState.copyWith();
    await _changedByFocusedDay(uiState.focusedDay);
  }

  @override
  update(UiState uiState) async {
    if (this.uiState!.focusedDay != uiState.focusedDay) {
      await _changedByFocusedDay(uiState.focusedDay);
    }

    this.uiState = uiState.copyWith();
  }
}
