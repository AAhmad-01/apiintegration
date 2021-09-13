import 'dart:convert';
import 'package:api/modal2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FutureHome extends StatefulWidget {
  @override
  _FutureHomeState createState() => _FutureHomeState();
}

class _FutureHomeState extends State<FutureHome> {
  late Future<List<Weathermodal>> newslist;
  Future<List<Weathermodal>> fetchdata() async {
    var response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=Apple&from=2021-09-11&sortBy=popularity&apiKey=010a106012f24b6387dfbb3c2699c049'));
    if (response.statusCode == 200) {
      final jsonrespone = jsonDecode(response.body);
      List newslist = jsonrespone['articles'];
      final outputmodel =
          newslist.map((e) => Weathermodal.fromjson(e)).toList();
      return outputmodel;
    } else
      throw Exception();
  }

  @override
  void initState() {
    // TODO: implement initState
    newslist = fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Weathermodal>>(
          future: newslist,
          initialData: [],
          builder: (context, snapshot) {
            var values = snapshot.data;
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: values!.length,
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            values[index].title,
                            style: TextStyle(fontSize: 28, color: Colors.white),
                          ),
                          Image.network(values[index].url),
                        ],
                      ),
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
