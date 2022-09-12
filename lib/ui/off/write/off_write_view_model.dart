import 'dart:io';

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
  final IconUseCase iconUseCase;

  OffWriteViewModel({
    required this.offDiaryUseCase,
    required this.offImageUseCase,
    required this.iconUseCase,
  });

  OffWriteState _state = OffWriteState();

  OffWriteState get state => _state;

  void onEvent(OffWriteEvent event) {
    event.when(
      addSelectedIconPaths: _addSelectedIconPaths,
      addSelectedImagePaths: _addSelectedImagePaths,
      saveTextContent: _saveTextContent,
      resetState: _resetState,
    );
  }

  void _addSelectedIconPaths(String path) {
    List<String> temp = [];
    temp.addAll(_state.iconPaths);
    temp.add(path);
    _state = _state.copyWith(iconPaths: temp);
    notifyListeners();
  }

  void _addSelectedImagePaths(File path) {
    List<File> temp = [];
    print("path $path");
    temp.addAll(_state.imagePaths);
    temp.add(path);
    _state = _state.copyWith(imagePaths: temp);
    notifyListeners();
  }

  void _saveTextContent(String text) async {
    print(this.uiState);

    OffDiary? offDiary = OffDiary(
      dateTime: dateTimeToUnixTime(this.uiState!.focusedDay),
      content: text,
    );

    await offDiaryUseCase.insert(offDiary);

    offDiary = await offDiaryUseCase.selectByDateTime(this.uiState!.focusedDay);

    List<OffImage> offImageList = [];

    for (var imageFile in state.imagePaths) {
      OffImage offImage = OffImage(
        offDiaryId: offDiary!.id!,
        path: imageFile.path,
      );
      offImageList.add(offImage);
    }

    await offImageUseCase.insertAll(offImageList);

    notifyListeners();
  }

  void _resetState() {
    _state = OffWriteState();
    notifyListeners();
  }

  @override
  init(UiState uiState) {
    this.uiState = uiState;
    print("uiState: $uiState");
    print("this.state: ${this.uiState}");

    notifyListeners();
  }

  @override
  update(UiState uiState) {
    this.uiState = uiState;

    notifyListeners();
  }
}
