import 'dart:collection';

import 'package:on_off/domain/entity/off/off_icon_entity.dart';
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
    iconMap: HashMap(),
    isAscending: true,
  );

  OffDiaryUseCase offDiaryUseCase;
  OffImageUseCase offImageUseCase;
  OffIconUseCase iconUseCase;

  OffListViewModel({
    required this.offDiaryUseCase,
    required this.offImageUseCase,
    required this.iconUseCase,
  });

  OffListState get state => _state;

  void onEvent(OffListEvent event) {
    event.when(
      changeContents: _changeContents,
      changeDiaryOrderType: _changeDiaryOrderType,
    );
  }

  void _changeDiaryOrderType() {
    List<Content> contentList = [];

    if (state.contents.isNotEmpty) {
      contentList = state.contents.reversed.toList();
    }

    _state = _state.copyWith(
      contents: contentList,
      isAscending: !_state.isAscending,
    );

    notifyListeners();
  }

  void _changeContents(DateTime selectedDate) async {
    DateTime startDateTime = DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime endDateTime =
        DateTime(selectedDate.year, selectedDate.month + 1, 0);

    _selectContents(startDateTime, endDateTime);
    _selectIcons(startDateTime, endDateTime);
  }

  void _selectContents(DateTime startDateTime, DateTime endDateTime) async {
    List<OffDiary> offDiaryList =
        await offDiaryUseCase.selectOffDiaryList(startDateTime, endDateTime);
    List<Content> contentList = [];

    for (var offDiary in offDiaryList) {
      List<OffImage> imageList =
          await offImageUseCase.selectOffImageList(offDiary.id!);

      var content = Content(
        time: unixToDateTime(offDiary.dateTime),
        content: offDiary.content,
        imageList: imageList,
      );

      contentList.add(content);
    }

    if (contentList.isNotEmpty && !state.isAscending) {
      contentList = contentList.reversed.toList();
    }

    _state = _state.copyWith(contents: contentList);

    notifyListeners();
  }

  void _selectIcons(DateTime startDateTime, DateTime endDateTime) async {
    List<OffIconEntity> iconEntityList =
        await iconUseCase.selectOffIconList(startDateTime, endDateTime);

    var iconMap = HashMap<int, OffIconEntity>();

    for (var iconEntity in iconEntityList) {
      DateTime dateTime = unixToDateTime(iconEntity.dateTime);
      iconMap[dateTime.day] = iconEntity;
    }
    _state = _state.copyWith(iconMap: iconMap);

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
