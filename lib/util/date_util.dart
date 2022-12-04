DateTime unixToDateTime(int unixtime) {
  return DateTime.fromMillisecondsSinceEpoch(unixtime);
}

int dateTimeToUnixTime(DateTime dateTime) {
  return dateTime.millisecondsSinceEpoch;
}

DateTime weekStartDate(DateTime dateTime) {
  int weekday = dateTime.weekday == 7 ? 0 : dateTime.weekday;
  return DateTime(
    dateTime.year,
    dateTime.month,
    dateTime.day - weekday,
  );
}

DateTime weekEndDate(DateTime dateTime) {
  int weekday = dateTime.weekday == 7 ? 0 : dateTime.weekday;
  return DateTime(
    dateTime.year,
    dateTime.month,
    dateTime.day + 6 - weekday,
  );
}
