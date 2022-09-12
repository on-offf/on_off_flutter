import 'package:flutter/material.dart';
import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:on_off/domain/entity/off/off_image.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/domain/use_case/data_source/off/off_diary_use_case.dart';
import 'package:on_off/domain/use_case/data_source/icon_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_image_use_case.dart';
import 'package:on_off/ui/off/home/off_home_event.dart';
import 'package:on_off/ui/off/home/off_home_state.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:on_off/util/date_util.dart';

class OffHomeViewModel extends UiProviderObserve {
  final OffDiaryUseCase offDiaryUseCase;
  final IconUseCase iconUseCase;
  final OffImageUseCase offImageUseCase;

  OffHomeViewModel({
    required this.offDiaryUseCase,
    required this.offImageUseCase,
    required this.iconUseCase,
  });

  OffHomeState _state = OffHomeState(
    offFocusMonthSelected: false,
  );

  OffHomeState get state => _state;

  void onEvent(OffHomeEvent event) {
    event.when(
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

  Future<List<String>> _findImagePathListByDiaryId(int diaryId) async {
    List<String> imagePathList = [];

    List<OffImage> imageList = await offImageUseCase.selectOffImageList(diaryId);
    for (var image in imageList) { imagePathList.add(image.path); }
    return imagePathList;
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
    } else {
      _state = _state.copyWith(content: null);
    }
    notifyListeners();
  }


  @override
  init(UiState uiState) {
    this.uiState = uiState;

    _changeFocusedDay(uiState.focusedDay);
  }

  @override
  update(UiState uiState) {
    if (this.uiState!.focusedDay != uiState.focusedDay) {
      _changeFocusedDay(uiState.focusedDay);
    }

    this.uiState = uiState.copyWith();
  }




}