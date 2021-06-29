extension StringExtension on String {
  /// Get short address by get characters max 2 coma by default.
  String getShortAddress({int length = 2, String splitCharacter = ","}) {
    final data = this;

    List<String> _splitted = data.split(splitCharacter);
    if (length == -1 || _splitted.length <= length) {
      return data;
    }

    String _res = "";
    for (int i = 0; i < length; i++) {
      _res += "${(_res != "" ? ", " : "")}${_splitted[i].trim()}";
    }

    return _res;
  }

  bool get isEmail {
    final data = this;
    String pattern =
        "^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(data.toString())) {
      return false;
    }

    return true;
  }

  bool get isValidIndonesiaNumber {
    final number = this;
    String pattern = "^62[0-9]{9,}";
    RegExp regExp = RegExp(pattern);

    var res = regExp.hasMatch(number.toString());
    return res;
  }
}
