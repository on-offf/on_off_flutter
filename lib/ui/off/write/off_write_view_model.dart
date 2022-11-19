import 'dart:io';

import 'package:on_off/domain/entity/off/off_icon_entity.dart';
import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:on_off/domain/entity/off/off_image.dart';
import 'package:on_off/domain/model/off_write_image.dart';
import 'package:on_off/domain/use_case/data_source/off/off_icon_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_diary_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_image_use_case.dart';
import 'package:on_off/ui/off/write/off_write_state.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:on_off/util/date_util.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'dart:math';

class OffWriteViewModel extends UiProviderObserve {
  final OffDiaryUseCase offDiaryUseCase;
  final OffImageUseCase offImageUseCase;
  final OffIconUseCase offIconUseCase;

  OffWriteViewModel({
    required this.offDiaryUseCase,
    required this.offImageUseCase,
    required this.offIconUseCase,
  });

  OffWriteState _state = OffWriteState();

  OffWriteState get state => _state;

  void removeContent() async {
    if (_state.offDiary == null) return;

    int diaryId = _state.offDiary!.id!;
    await offDiaryUseCase.delete(diaryId);
    await offImageUseCase.deleteByDiaryId(diaryId);
  }

  void removeImage(OffWriteImage selectedImage) async {
    if (selectedImage.id != null) {
      await offImageUseCase.delete(selectedImage.id!);
    }

    List<OffWriteImage> offWriteImage = [];

    for (var offImage in _state.imagePaths) {
      if (offImage != selectedImage) {
        offWriteImage.add(offImage);
      }
    }
    _state = _state.copyWith(imagePaths: offWriteImage);
    notifyListeners();
  }

  Future<void> getFocusedDayDetail() async {
    OffIconEntity? icon =
        await offIconUseCase.selectOffIcon(uiState!.focusedDay);
    _state = _state.copyWith(icon: icon);

    OffDiary? offDiary =
        await offDiaryUseCase.selectByDateTime(uiState!.focusedDay);

    if (offDiary == null) {
      notifyListeners();
      return;
    }

    var imageList = await _setOffImageList(offDiary.id!);
    _state = _state.copyWith(
      offDiary: offDiary,
      imagePaths: imageList,
    );

    notifyListeners();
  }

  Future<List<OffWriteImage>> _setOffImageList(int diaryId) async {
    List<OffImage> offImageList =
        await offImageUseCase.selectOffImageList(diaryId);
    List<OffWriteImage> list = [];

    for (var offImage in offImageList) {
      final chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      final random = Random();

      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(getRandomString(random, chars, 5));
      final savedImage = File('${appDir.path}/$fileName');
      savedImage.writeAsBytes(offImage.imageFile);

      var image = OffWriteImage(
        id: offImage.id,
        diaryId: offImage.offDiaryId,
        file: savedImage,
      );
      list.add(image);
    }

    return list;
  }

  String getRandomString(random, chars, int length) {
    return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

  void addIcon(String path) async {
    OffIconEntity icon = await offIconUseCase.insert(uiState!.focusedDay, path);
    _state = _state.copyWith(icon: icon);
    notifyListeners();
  }

  void addSelectedImagePaths(File path) {
    List<OffWriteImage> temp = [];
    temp.addAll(_state.imagePaths);
    temp.add(OffWriteImage(file: path));
    _state = _state.copyWith(imagePaths: temp);
    notifyListeners();
  }

  void saveContent(String title, String content) async {
    int offDiaryId;
    if (_state.offDiary != null) {
      OffDiary offDiary = OffDiary(
        id: _state.offDiary!.id,
        dateTime: _state.offDiary!.dateTime,
        title: title,
        content: content,
      );
      await offDiaryUseCase.update(offDiary);
      offDiaryId = _state.offDiary!.id!;
    } else {
      OffDiary? offDiary = OffDiary(
        dateTime: dateTimeToUnixTime(uiState!.focusedDay),
        title: title,
        content: content,
      );
      offDiary = await offDiaryUseCase.insert(offDiary);
      offDiaryId = offDiary.id!;
    }
    _saveDiaryImageList(offDiaryId);
    notifyListeners();
  }

  void _saveDiaryImageList(int id) async {
    List<OffImage> offImageList = [];
    for (var offWriteImage in state.imagePaths) {
      if (offWriteImage.id != null) continue;

      OffImage offImage = OffImage(
        offDiaryId: id,
        imageFile: offWriteImage.file.readAsBytesSync(),
      );
      offImageList.add(offImage);
    }
    await offImageUseCase.insertAll(offImageList);
  }

  void _getIcon(DateTime focuesdDay) async {
    OffIconEntity? icon = await offIconUseCase.selectOffIcon(focuesdDay);
    _state = _state.copyWith(icon: icon);
  }

  void resetState() {
    _state = OffWriteState();
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
