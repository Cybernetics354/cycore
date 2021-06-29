part of extension;

extension DateTimeExtension on DateTime {
  String tanggal({bool shortMonth = false}) {
    final date = this;
    return "${date.day} ${_convertToLocalMonth(date.month, shortMonth)} ${date.year}";
  }

  String _convertToLocalMonth(int month, bool shortMonth) {
    if (shortMonth) return _shortMonth[month - 1];
    return _longMonth[month - 1];
  }

  /// **By default, compare with DateTime.now()**
  ///
  /// compare based on selected time
  bool compareDateTime({
    DateTime? compareTime,
    bool withYear = true,
    bool withMonth = true,
    bool withDay = true,
    bool withHour = false,
    bool withMinute = false,
    bool withSecond = false,
    bool withMillisecond = false,
  }) {
    final _cdate = this;
    var now = compareTime ?? DateTime.now();
    bool isNow = true;

    if (withYear) isNow = isNow && _cdate.year == now.year;
    if (withMonth) isNow = isNow && _cdate.month == now.month;
    if (withDay) isNow = isNow && _cdate.day == now.day;
    if (withHour) isNow = isNow && _cdate.hour == now.hour;
    if (withMinute) isNow = isNow && _cdate.minute == now.minute;
    if (withSecond) isNow = isNow && _cdate.second == now.second;
    if (withMillisecond) isNow = isNow && _cdate.millisecond == now.millisecond;

    return isNow;
  }

  /// Get timestamp label
  String getTimeStamp({
    bool withHourAndMinutes = true,
    String separator = ", ",
  }) {
    final dateTime = this;
    if (!withHourAndMinutes) return dateTime.tanggal();

    return dateTime.tanggal() + separator + DateFormat("Hm").format(dateTime).toString();
  }

  DateTimeDifference getDifference({DateTime? compare}) {
    DateTime _compare = DateTime.now();

    if (compare != null) _compare = compare;

    return DateTimeDifference(
      currentTime: this,
      comparedTime: _compare,
    );
  }
}

List _longMonth = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
];

List _shortMonth = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'Mei',
  'Jun',
  'Jul',
  'Agu',
  'Sep',
  'Okt',
  'Nov',
  'Des',
];
