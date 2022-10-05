import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/domain/entity/off/off_icon_entity.dart';

part 'off_daily_event.freezed.dart';

@freezed
abstract class OffDailyEvent with _$OffDailyEvent {
  const factory OffDailyEvent.changeCurrentIndex(int currentIndex) = ChangeCurrentIndex;
  const factory OffDailyEvent.getIcon(OffIconEntity? icon) = GetIcon;
  const factory OffDailyEvent.addIcon(DateTime selectedDate, String path) = AddIcon;
}