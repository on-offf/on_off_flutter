import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_off/domain/entity/off/off_icon_entity.dart';
import 'package:on_off/domain/model/content.dart';

part 'off_daily_event.freezed.dart';

@freezed
abstract class OffDailyEvent with _$OffDailyEvent {
  const factory OffDailyEvent.changeCurrentIndex(int currentIndex) = ChangeCurrentIndex;
  const factory OffDailyEvent.setIcon(OffIconEntity? icon) = SetIcon;
  const factory OffDailyEvent.setContent(Content content) = SetContent;
  const factory OffDailyEvent.addIcon(DateTime selectedDate, String path) = AddIcon;
  const factory OffDailyEvent.changeDay(bool isBefore) = ChangeDay;
}