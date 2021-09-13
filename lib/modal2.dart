class Weathermodal {
  late String title;
  late String url;
  Weathermodal({required this.title, required this.url});

  Weathermodal.fromjson(Map<String, dynamic> parsedjson) {
    this.title = parsedjson['title'];
    this.url = parsedjson['urlToImage'];
  }
}
