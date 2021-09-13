import 'dart:convert';

import 'package:api/modal2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MapHome extends StatefulWidget {
  @override
  _MapHomeState createState() => _MapHomeState();
}

class _MapHomeState extends State<MapHome> {
  late Map apiresponse;
  List<Weathermodal>? listofaritcles = [];
  String title = 'wait';
  String url = 'wait';
  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future<List?> fetchdata() async {
    var response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=Apple&from=2021-09-11&sortBy=popularity&apiKey=010a106012f24b6387dfbb3c2699c049'));
    if (response.statusCode == 200) {
      var stringresponse = response.body;
      final jsonobject = jsonDecode(stringresponse);
      List jsonmap = jsonobject['articles'];
      final movies = jsonmap.map((e) => Weathermodal.fromjson(e)).toList();
      return movies;
    } else
      return null;
  }

  Future initialize() async {
    List<Weathermodal> movies;
    movies = (await fetchdata()) as List<Weathermodal>;
    setState(() {
      listofaritcles = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: listofaritcles!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Text(listofaritcles![index].title),
                          Image.network(listofaritcles![index].url),
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
