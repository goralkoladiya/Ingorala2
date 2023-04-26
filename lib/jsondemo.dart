import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class jsondemo extends StatefulWidget {
  const jsondemo({Key? key}) : super(key: key);

  @override
  State<jsondemo> createState() => _jsondemoState();
}

class _jsondemoState extends State<jsondemo> {
  get()
  async {
    String apiURL = "https://ingoralajagani.cdmi.in/getcontact.php";
    var apiResult = await http.get(Uri.parse(apiURL));
    Map map=jsonDecode(apiResult.body);
    List list = map['result'];
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
