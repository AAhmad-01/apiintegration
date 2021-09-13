import 'dart:convert';

import 'package:api/getdata.dart';
import 'package:api/modal.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var result = ' waiting';
  late GetData getData;

  @override
  void initState() {
    // TODO: implement initState
    getData = GetData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getData.getData().then((value) {
      setState(() {
        result = value!;
      });
    });
    Map jsonobject = jsonDecode(result);

    return Scaffold(
      body: Text(jsonobject[2]),
    );
  }
}
