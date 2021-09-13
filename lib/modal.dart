class News {
  late String author;
  late String title;

  News({required this.author, required this.title});

  News.fromJson(Map<String, dynamic> parsedjson) {
    this.author = parsedjson['author'];
    this.title = parsedjson['title'];
  }
}
