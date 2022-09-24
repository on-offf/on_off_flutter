import 'package:flutter/material.dart';
import 'package:on_off/domain/entity/icon_entity.dart';
import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:on_off/domain/entity/off/off_image.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/domain/use_case/data_source/off/off_diary_use_case.dart';
import 'package:on_off/domain/use_case/data_source/icon_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_image_use_case.dart';
import 'package:on_off/ui/off/monthly/off_monthly_event.dart';
import 'package:on_off/ui/off/monthly/off_monthly_state.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:on_off/util/date_util.dart';

class OffMonthlyViewModel extends UiProviderObserve {
  final OffDiaryUseCase offDiaryUseCase;
  final IconUseCase iconUseCase;
  final OffImageUseCase offImageUseCase;

  OffMonthlyViewModel({
    required this.offDiaryUseCase,
    required this.offImageUseCase,
    required this.iconUseCase,
  });

  OffMonthlyState _state = OffMonthlyState(
    offFocusMonthSelected: false,
  );

  OffMonthlyState get state => _state;

  void onEvent(OffMonthlyEvent event) {
    event.when(
      offFocusMonthSelected: _offFocusMonthSelected,
      showOverlay: _showOverlay,
      removeOverlay: _removeOverlay,

      // Icon
      addSelectedIconPaths: _addSelectedIconPaths,
    );
  }

  void _addSelectedIconPaths(String path) async {
    List<IconEntity> iconList =
        await iconUseCase.selectListByDateTime(uiState!.focusedDay);
    bool saveIcon = true;

    for (var iconEntity in iconList) {
      if (iconEntity.name == path) saveIcon = false;
    }

    if (saveIcon) {
      await iconUseCase.insert(uiState!.focusedDay, path);
      _addIconPathInState(path);

      notifyListeners();
    }
  }

  void _addIconPathInState(String path) {
    List<String> iconPathList = [];
    iconPathList.addAll(_state.iconPaths);
    iconPathList.add(path);
    _state = _state.copyWith(iconPaths: iconPathList);
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
    _state =
        _state.copyWith(offFocusMonthSelected: !_state.offFocusMonthSelected);
    notifyListeners();
  }

  void _changeFocusedDay(DateTime focusedDay) async {
    OffDiary? offDiary = await offDiaryUseCase.selectByDateTime(focusedDay);

    if (offDiary != null) {
      List<OffImage> imageList = await offImageUseCase.selectOffImageList(offDiary.id!);

      Content content = Content(
        time: unixToDateTime(offDiary.dateTime),
        imageList: imageList,
        content: offDiary.content,
      );

      _state = _state.copyWith(content: content);
    } else {
      _state = _state.copyWith(content: null);
    }

    List<IconEntity> list = await iconUseCase.selectListByDateTime(focusedDay);
    List<String> iconPaths = [];

    for (var iconEntity in list) {
      iconPaths.add(iconEntity.name);
    }

    _state = _state.copyWith(iconPaths: iconPaths);

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
