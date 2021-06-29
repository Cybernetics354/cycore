part of extension;

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDayDifferent getDifferent({
    TimeOfDay? compare,
  }) =>
      TimeOfDayDifferent(
        currentTime: this,
        comparedTime: compare ?? TimeOfDay.now(),
      );
}
