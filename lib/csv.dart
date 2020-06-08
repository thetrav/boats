

List<Map<String, String>> read(String source) {
  final List<List<String>>lines = source.replaceAll("\r", "").split("\n").map((l)=> l.split(",")).toList();
  final headers = lines.first;
  return lines.sublist(1).map((list) {
    final row = Map<String, String>();
    List<int>.generate(headers.length, (i) => i).forEach((i) {
      row[headers[i]] = list[i];
    });
    return row;
  }).toList();
}