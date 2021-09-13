import 'dart:convert';

import 'package:api/modal.dart';
import 'package:http/http.dart' as http;

class GetData {
  Future<String?> getData() async {
    var response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=Apple&from=2021-09-11&sortBy=popularity&apiKey=010a106012f24b6387dfbb3c2699c049'));
    if (response.statusCode == 200) {
      String responsebody = response.body;
      print(response.statusCode);
      return responsebody;
    } else {
      return null;
    }
  }
}
