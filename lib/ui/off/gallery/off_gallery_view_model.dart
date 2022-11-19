import 'package:on_off/domain/entity/off/off_image.dart';
import 'package:on_off/domain/use_case/data_source/off/off_diary_use_case.dart';
import 'package:on_off/domain/use_case/data_source/off/off_image_use_case.dart';
import 'package:on_off/ui/off/gallery/off_gallery_state.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';

class OffGalleryViewModel extends UiProviderObserve {
  final OffDiaryUseCase offDiaryUseCase;
  final OffImageUseCase offImageUseCase;

  OffGalleryViewModel({
    required this.offDiaryUseCase,
    required this.offImageUseCase,
  });

  OffGalleryState _state = OffGalleryState(
    offImageList: [],
    index: 0,
  );

  OffGalleryState get state => _state;

  void initScreen(List<OffImage> offImageList) async {
    _state = _state.copyWith(offImageList: offImageList);
  }

  void changeIndex(int index) {
    _state = _state.copyWith(index: index);
    notifyListeners();
  }

  @override
  init(UiState uiState) {
    this.uiState = uiState.copyWith();
  }

  @override
  update(UiState uiState) {
    this.uiState = uiState.copyWith();
  }
}
