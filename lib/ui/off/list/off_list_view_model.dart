import 'dart:collection';

import 'package:on_off/domain/entity/icon_entity.dart';
import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:on_off/domain/entity/off/off_image.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/domain/use_case/data_source/icon_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_diary_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_image_use_case.dart';
import 'package:on_off/ui/off/list/off_list_event.dart';
import 'package:on_off/ui/off/list/off_list_state.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:on_off/util/date_util.dart';

class OffListViewModel extends UiProviderObserve {
  OffListState _state = OffListState(
    contents: [],
  );

  OffDiaryUseCase offDiaryUseCase;
  OffImageUseCase offImageUseCase;
  IconUseCase iconUseCase;

  OffListViewModel({
    required this.offDiaryUseCase,
    required this.offImageUseCase,
    required this.iconUseCase,
  });

  OffListState get state => _state;

  void onEvent(OffListEvent event) {
    event.when(
      changeContents: _changeContents,
      addSelectedIconPaths: _addSelectedIconPaths,
    );
  }

  void _addSelectedIconPaths(DateTime selectedDate, String path) async {
    selectedDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    print(selectedDate);

    List<String>? iconPathList = _state.iconPathMap![selectedDate.day];

    if (iconPathList == null) {
      iconPathList = [];
      iconPathList.add(path);
    } else {
      bool saveIcon = true;

      for (var iconPath in iconPathList) {
        if (iconPath == path) saveIcon = false;
      }

      if (saveIcon) {
        IconEntity entity = IconEntity(
          dateTime: dateTimeToUnixTime(uiState!.focusedDay),
          name: path,
        );

        await iconUseCase.insert(entity);
        _addIconPathInState(selectedDate, path);

        notifyListeners();
      }
    }
  }

  void _addIconPathInState(DateTime selectedDate, String path) {
    List<String> iconPathList = [];

    iconPathList.addAll(_state.iconPathMap![selectedDate.day]!);
    iconPathList.add(path);

    _state.iconPathMap![selectedDate.day] = iconPathList;
  }

  void _changeContents(DateTime selectedDate) async {
    print('changeContents');
    DateTime startDateTime = DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime endDateTime = DateTime(
        selectedDate.year, selectedDate.month + 1, 0);

    _selectContents(startDateTime, endDateTime);
    _selectIcons(startDateTime, endDateTime);
  }

  void _selectContents(DateTime startDateTime, DateTime endDateTime) async {
    List<OffDiary> offDiaryList = await offDiaryUseCase.selectOffDiaryList(
        startDateTime, endDateTime);
    List<Content> contentList = [];

    for (var offDiary in offDiaryList) {
      List<String> imagePathList = await _getImagePathByDiaryId(offDiary.id!);

      var content = Content(
        time: unixToDateTime(offDiary.dateTime),
        content: offDiary.content,
        imagePaths: imagePathList,
      );

      contentList.add(content);
    }
    _state = _state.copyWith(contents: contentList);

    notifyListeners();
  }

  void _selectIcons(DateTime startDateTime, DateTime endDateTime) async {
    List<IconEntity> iconEntityList = await iconUseCase.selectOffIconList(startDateTime, endDateTime);

    var iconPathMap = HashMap<int, List<String>>();
    for (var iconEntity in iconEntityList) {
      DateTime dateTime = unixToDateTime(iconEntity.dateTime);

      if (iconPathMap[dateTime.day] == null) {
        iconPathMap.putIfAbsent(dateTime.day, () => []);
        iconPathMap[dateTime.day]?.add(iconEntity.name);
      } else {
        iconPathMap[dateTime.day]?.add(iconEntity.name);
      }
    }

    print(iconPathMap);

    _state = _state.copyWith(iconPathMap: iconPathMap);

    notifyListeners();
  }

  Future<List<String>> _getImagePathByDiaryId(int diaryId) async {
    List<OffImage> offImageList = await offImageUseCase.selectOffImageList(
        diaryId);
    List<String> imagePathList = [];

    for (var value in offImageList) {
      imagePathList.add(value.path);
    }

    return imagePathList;
  }

  @override
  init(UiState uiState) async {
    this.uiState = uiState;
    _changeContents(uiState.focusedDay);
  }

  @override
  update(UiState uiState) async {
    if (this.uiState!.focusedDay != uiState.focusedDay) {
      _changeContents(uiState.focusedDay);
    }

    this.uiState = uiState;
  }

}