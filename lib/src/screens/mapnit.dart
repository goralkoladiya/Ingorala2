import 'package:ingorala/src/models/mapun.dart';
import 'package:flutter/material.dart';

class DaftarUnit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Maps Daftar Unit'),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(children: <Widget>[
            GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyList1(),
              ),
            );
          },
          child : Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
            child: Text(
              'Unit A',
              style: TextStyle(fontSize: 19),
            ),
            ),
          ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyList2(),
              ),
            );
          },
          child : Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
            child: Text(
              'Unit B',
              style: TextStyle(fontSize: 19),
            ),
            ),
          ),
          ),
          ],)
      )
      );
  }
}
