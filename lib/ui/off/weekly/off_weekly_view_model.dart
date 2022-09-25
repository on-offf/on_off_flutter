import 'dart:collection';

import 'package:on_off/domain/entity/icon_entity.dart';
import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:on_off/domain/entity/off/off_image.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/domain/use_case/data_source/icon_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_diary_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_image_use_case.dart';
import 'package:on_off/ui/off/weekly/off_weekly_event.dart';
import 'package:on_off/ui/off/weekly/off_weekly_state.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:on_off/util/date_util.dart';

class OffWeeklyViewModel extends UiProviderObserve {
  OffWeeklyState _state = OffWeeklyState(
    contents: [],
    iconPathMap: HashMap(),
  );

  OffDiaryUseCase offDiaryUseCase;
  OffImageUseCase offImageUseCase;
  IconUseCase iconUseCase;

  OffWeeklyViewModel({
    required this.offDiaryUseCase,
    required this.offImageUseCase,
    required this.iconUseCase,
  });

  OffWeeklyState get state => _state;

  void onEvent(OffWeeklyEvent event) {
    event.when(
      changeContents: _changeContents,
      addSelectedIconPaths: _addSelectedIconPaths,
    );
  }

  void _addSelectedIconPaths(DateTime selectedDate, String path) async {
    selectedDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    List<String>? iconPathList = _state.iconPathMap[selectedDate.weekday];

    bool saveIcon = true;

    for (var iconPath in iconPathList!) {
      if (iconPath == path) saveIcon = false;
    }

    if (saveIcon) {
      await iconUseCase.insert(selectedDate, path);
      iconPathList.add(path);

      Map<int, List<String>> iconPathMap = HashMap();

      _state.iconPathMap.forEach((key, value) {
        if (selectedDate.day == key) {
          iconPathMap[key] = iconPathList;
        } else {
          iconPathMap[key] = _state.iconPathMap[key]!;
        }
      });

      _state = _state.copyWith(iconPathMap: iconPathMap);

      notifyListeners();
    }
  }

  void _changeContents(DateTime selectedDate) async {
    DateTime startDateTime = weekStartDate(selectedDate);
    DateTime endDateTime = weekEndDate(selectedDate);

    _selectContents(startDateTime, endDateTime);
    _selectIcons(startDateTime, endDateTime);
  }

  void _selectContents(DateTime startDateTime, DateTime endDateTime) async {
    List<OffDiary> offDiaryList = await offDiaryUseCase.selectOffDiaryList(
        startDateTime, endDateTime);
    List<Content> contentList = [];

    for (var offDiary in offDiaryList) {
      List<OffImage> imageList = await offImageUseCase.selectOffImageList(offDiary.id!);

      var content = Content(
        time: unixToDateTime(offDiary.dateTime),
        content: offDiary.content,
        imageList: imageList,
      );

      contentList.add(content);
    }
    _state = _state.copyWith(contents: contentList);

    notifyListeners();
  }

  void _selectIcons(DateTime startDateTime, DateTime endDateTime) async {
    List<IconEntity> iconEntityList = await iconUseCase.selectOffIconList(startDateTime, endDateTime);

    var iconPathMap = HashMap<int, List<String>>();

    // flutter dateTime의 weekday는 1(월)부터 7(일)까지
    for (int index = 1; index <= 7; index++) {
      iconPathMap[index] = [];
    }

    for (var iconEntity in iconEntityList) {
      DateTime dateTime = unixToDateTime(iconEntity.dateTime);

      if (iconPathMap[dateTime.weekday] == null) {
        iconPathMap.putIfAbsent(dateTime.weekday, () => []);
        iconPathMap[dateTime.weekday]?.add(iconEntity.name);
      } else {
        iconPathMap[dateTime.weekday]?.add(iconEntity.name);
      }
    }
    _state = _state.copyWith(iconPathMap: iconPathMap);

    notifyListeners();
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