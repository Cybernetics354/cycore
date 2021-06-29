part of extension;

extension NumExtension on num {
  String rupiah({String separator = '.', String trailing = ''}) {
    String _val = "Rp ";
    RegExp _regPattern = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

    _val += this.toString().replaceAllMapped(_regPattern, (m) => '${m[1]}$separator');
    _val += trailing;

    return _val;
  }
}
