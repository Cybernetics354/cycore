part of extension;

class TimeOfDayDifferent {
  TimeOfDay currentTime;
  TimeOfDay comparedTime;

  TimeOfDayDifferent({
    required this.currentTime,
    required this.comparedTime,
  });

  int get hourDif => currentTime.hour - comparedTime.hour;
  int get minuteDif => currentTime.minute - comparedTime.minute;

  bool get isPast {
    if (hourDif > 0) return false;
    if (minuteDif >= 0) return false;

    return true;
  }

  String getDifferentiesLabel({
    String pastlabel = "yang lalu",
    String futureLabel = "lagi",
    bool showParamslabel = true,
    Duration? maxDuration,
    String placeHolder = "",
  }) {
    int hour = hourDif;
    int minutes = minuteDif;

    if (maxDuration != null) {
      if ((hour.abs() * 60) + minutes.abs() > maxDuration.inMinutes) return placeHolder;
    }

    if (hour < 0 || hour > 0)
      return <String>[hour.abs().toString(), "jam", hour < 0 ? pastlabel : futureLabel].join(" ");

    return <String>[minutes.abs().toString(), "menit", minutes < 0 ? pastlabel : futureLabel]
        .join(" ");
  }
}
