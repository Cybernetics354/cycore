part of extension;

extension IntExtension on int {
  /// Convert int into something like 2 jam 3 menit.
  String intToTimeLabel({bool useStringLabel = true}) {
    final count = this;

    int seconds;
    int minutes;
    int hours;
    int day;
    int month;

    seconds = count % 60;
    minutes = count ~/ 60;
    hours = minutes ~/ 60;
    day = hours ~/ 24;
    month = day ~/ 30;

    minutes = minutes % 60;
    hours = hours % 24;
    day = day % 30;

    List<String> res = [];

    if (month > 0) {
      res.add("$month Bulan");
    }

    if (day > 0) {
      res.add("$day Hari");
    }

    if (hours > 0) {
      res.add("$hours Jam");
    }

    if (minutes > 0) {
      res.add("$minutes Menit");
    }

    if (seconds > 0) {
      res.add("$seconds Detik");
    }

    if (res.isEmpty) return "-";
    return res.join(", ");
  }
}
