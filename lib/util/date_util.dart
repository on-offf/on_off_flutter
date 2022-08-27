DateTime unixToDateTime(int unixtime) {
  return DateTime.fromMillisecondsSinceEpoch(unixtime);
}

int dateTimeToUnixTime(DateTime dateTime) {
  return dateTime.millisecondsSinceEpoch;
}