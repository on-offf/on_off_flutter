import 'dart:io';

import 'package:on_off/domain/entity/off/off_icon_entity.dart';
import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:on_off/domain/entity/off/off_image.dart';
import 'package:on_off/domain/use_case/data_source/icon_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_diary_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_image_use_case.dart';
import 'package:on_off/ui/off/write/off_write_event.dart';
import 'package:on_off/ui/off/write/off_write_state.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:on_off/util/date_util.dart';

class OffWriteViewModel extends UiProviderObserve {
  final OffDiaryUseCase offDiaryUseCase;
  final OffImageUseCase offImageUseCase;
  final OffIconUseCase iconUseCase;

  OffWriteViewModel({
    required this.offDiaryUseCase,
    required this.offImageUseCase,
    required this.iconUseCase,
  });

  OffWriteState _state = OffWriteState();

  OffWriteState get state => _state;

  void onEvent(OffWriteEvent event) {
    event.when(
      addIcon: _addIcon,
      addSelectedImagePaths: _addSelectedImagePaths,
      saveContent: _saveContent,
      resetState: _resetState,
    );
  }

  void _addIcon(String path) async {
    OffIconEntity icon = await iconUseCase.insert(uiState!.focusedDay, path);
    _state = _state.copyWith(icon: icon);
    notifyListeners();
  }

  void _addSelectedImagePaths(File path) {
    List<File> temp = [];
    temp.addAll(_state.imagePaths);
    temp.add(path);
    _state = _state.copyWith(imagePaths: temp);
    notifyListeners();
  }

  void _saveContent(String text) async {
    OffDiary? offDiary = OffDiary(
      dateTime: dateTimeToUnixTime(uiState!.focusedDay),
      content: text,
    );
    offDiary = await offDiaryUseCase.insert(offDiary);
    _saveDiaryImageList(offDiary.id!);
    notifyListeners();
  }

  void _saveDiaryImageList(int id) async {
    List<OffImage> offImageList = [];
    for (var imageFile in state.imagePaths) {
      OffImage offImage = OffImage(
        offDiaryId: id,
        imageFile: imageFile.readAsBytesSync(),
      );
      offImageList.add(offImage);
    }
    await offImageUseCase.insertAll(offImageList);
  }

  void _getIcon(DateTime focuesdDay) async {
    OffIconEntity? icon = await iconUseCase.selectOffIcon(focuesdDay);
    _state = _state.copyWith(icon: icon);
  }

  void _resetState() {
    _state = OffWriteState();
    notifyListeners();
  }

  @override
  init(UiState uiState) {
    this.uiState = uiState;

    notifyListeners();
  }

  @override
  update(UiState uiState) {

    if (this.uiState?.focusedDay != uiState.focusedDay) {
      _getIcon(uiState.focusedDay);
    }

    this.uiState = uiState;

    notifyListeners();
  }
}
