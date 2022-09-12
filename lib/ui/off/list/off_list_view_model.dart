import 'package:on_off/domain/entity/off/off_diary.dart';
import 'package:on_off/domain/entity/off/off_image.dart';
import 'package:on_off/domain/model/content.dart';
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

  OffListViewModel({required this.offDiaryUseCase, required this.offImageUseCase});

  OffListState get state => _state;

  void onEvent(OffListEvent event) {
    event.when(
        changeContents: _changeContents,
    );
  }

  void _changeContents(DateTime selectedDate) async {
    DateTime startDateTime = DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime endDateTime = DateTime(selectedDate.year, selectedDate.month + 1, 0);

    List<OffDiary> offDiaryList = await offDiaryUseCase.selectOffDiaryList(startDateTime, endDateTime);
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

  Future<List<String>> _getImagePathByDiaryId(int diaryId) async {
    List<OffImage> offImageList = await offImageUseCase.selectOffImageList(diaryId);
    List<String> imagePathList = [];

    for (var value in offImageList) {
      imagePathList.add(value.path);
    }

    return imagePathList;
  }

  @override
  init(UiState uiState) {
    this.uiState = uiState;
  }

  @override
  update(UiState uiState) {
    this.uiState = uiState;
  }

}