import 'package:on_off/ui/on/home/on_home_event.dart';
import 'package:on_off/ui/on/home/on_home_state.dart';
import 'package:on_off/ui/provider/ui_provider_observe.dart';
import 'package:on_off/ui/provider/ui_state.dart';

class OnHomeViewModel extends UiProviderObserve {
  OnHomeState _state = OnHomeState(
    test: false,
  );

  void onEvent(OnHomeEvent event) {
    event.when(
      test: _test,
    );
  }

  void _test() {
    notifyListeners();
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