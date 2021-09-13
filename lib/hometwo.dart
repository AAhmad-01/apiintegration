import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepagetwo extends StatefulWidget {
  @override
  _HomepagetwoState createState() => _HomepagetwoState();
}

class _HomepagetwoState extends State<Homepagetwo> {
  late String stringresponse;
  late List newslist;
  late Map mapresponse;
  late List listoffacts;
  Future fetchdata() async {
    var response = await http
        .get(Uri.parse('https://thegrowingdeveloper.org/apiview?id=2'));
    if (response.statusCode == 200) {
      setState(() {
        mapresponse = jsonDecode(response.body);
        listoffacts = mapresponse['facts'];
      });
    } else {
      print('not getting data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data from Internet'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Text(mapresponse['category'].toString()),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: listoffacts.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.network(listoffacts[index]['image_url']),
                        Text(listoffacts[index]['title']),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
