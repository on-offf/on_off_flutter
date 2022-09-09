import 'package:flutter/material.dart';
import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:on_off/domain/entity/off/off_image.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/domain/use_case/data_source/off/off_diary_use_case.dart';
import 'package:on_off/domain/use_case/data_source/icon_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_image_use_case.dart';
import 'package:on_off/ui/off/home/off_home_event.dart';
import 'package:on_off/ui/off/home/off_home_state.dart';
import 'package:on_off/util/date_util.dart';

class OffHomeViewModel with ChangeNotifier {
  final OffDiaryUseCase offDiaryUseCase;
  final IconUseCase iconUseCase;
  final OffImageUseCase offImageUseCase;

  OffHomeViewModel({
    required this.offDiaryUseCase,
    required this.offImageUseCase,
    required this.iconUseCase,
  });

  OffHomeState _state = OffHomeState(
    selectedDay: DateTime.now(),
    focusedDay: DateTime.now(),
    changeCalendarPage: DateTime.now(),
    offFocusMonthSelected: false,
  );

  OffHomeState get state => _state;

  void onEvent(OffHomeEvent event) {
    event.when(
      changeSelectedDay: _changeSelectedDay,
      changeFocusedDay: _changeFocusedDay,
      changeCalendarPage: _changeCalendarPage,
      offFocusMonthSelected: _offFocusMonthSelected,
      showOverlay: _showOverlay,
      removeOverlay: _removeOverlay,
    );
  }

  void _showOverlay(BuildContext context, OverlayEntry changeOverlayEntry) {
    _state = state.copyWith(overlayEntry: changeOverlayEntry);
    notifyListeners();
  }

  void _removeOverlay() {
    _state.overlayEntry?.remove();
    _state = state.copyWith(overlayEntry: null);
    notifyListeners();
  }

  void _offFocusMonthSelected() {
    _state = _state.copyWith(offFocusMonthSelected: !_state.offFocusMonthSelected);
    notifyListeners();
  }

  void _changeCalendarPage(DateTime changeCalendarPage) {
    _state = _state.copyWith(changeCalendarPage: changeCalendarPage);
    notifyListeners();
  }

  void _changeSelectedDay(DateTime selectedDay) {
    _state = _state.copyWith(selectedDay: selectedDay);
    notifyListeners();
  }

  void _changeFocusedDay(DateTime focusedDay) async {
    OffDiary? offDiary = await offDiaryUseCase.selectByDateTime(focusedDay);

    if (offDiary != null) {
      List<String> imagePathList = await _findImagePathListByDiaryId(offDiary.id!);
      Content content = Content(
        time: unixToDateTime(offDiary.dateTime),
        imagePaths: imagePathList,
        content: offDiary.content,
      );

      _state = _state.copyWith(content: content);
    }

    _state = _state.copyWith(focusedDay: focusedDay);
    notifyListeners();
  }

  Future<List<String>> _findImagePathListByDiaryId(int diaryId) async {
    List<String> imagePathList = [];

    List<OffImage> imageList = await offImageUseCase.selectOffImageList(diaryId);
    for (var image in imageList) { imagePathList.add(image.path); }
    return imagePathList;
  }


}