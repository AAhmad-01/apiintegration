import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weatherhome extends StatefulWidget {
  @override
  _WeatherhomeState createState() => _WeatherhomeState();
}

class _WeatherhomeState extends State<Weatherhome> {
  late Map apiresponse;
  late List listofaritcles;
  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  Future fetchdata() async {
    var response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=Apple&from=2021-09-11&sortBy=popularity&apiKey=010a106012f24b6387dfbb3c2699c049'));
    if (response.statusCode == 200) {
      var stringresponse = response.body;
      var jsonmap = jsonDecode(stringresponse);
      setState(() {
        listofaritcles = jsonmap['articles'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Text(
                listofaritcles[0]['author'].toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: listofaritcles.length,
                  itemBuilder: (contxt, index) {
                    return Card(
                      child: Column(
                        children: [
                          Text(listofaritcles[index]['title']),
                          Image.network(listofaritcles[index]['urlToImage']),
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
