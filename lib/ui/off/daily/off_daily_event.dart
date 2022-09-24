import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_daily_event.freezed.dart';

@freezed
abstract class OffDailyEvent with _$OffDailyEvent {
  const factory OffDailyEvent.changeCurrentIndex(int currentIndex) = ChangeCurrentIndex;
  const factory OffDailyEvent.getIconPaths(List<String> iconpaths) = GetIconPaths;
  const factory OffDailyEvent.addSelectedIconPaths(DateTime selectedDate, String path) = AddSelectedIconPaths;
}