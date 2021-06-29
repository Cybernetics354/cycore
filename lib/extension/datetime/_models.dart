part of extension;

class DateTimeDifference {
  DateTime currentTime;
  DateTime comparedTime;

  DateTimeDifference({
    required this.currentTime,
    required this.comparedTime,
  });

  bool get isAfter => currentTime.isAfter(comparedTime);
  bool get isBefore => currentTime.isBefore(comparedTime);
  Duration get duration => currentTime.difference(comparedTime);
}
