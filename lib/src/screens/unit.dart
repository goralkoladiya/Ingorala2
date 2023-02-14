import 'package:ingorala/src/screens/post_unit.dart';
import 'package:flutter/material.dart';

void main() => runApp(Unit());

class Unit extends StatefulWidget {
  @override
  _UnitState createState() => _UnitState();
}

class _UnitState extends State<Unit> {
  PostResult? postResult = null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Unit"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text((postResult != null)
                  ? postResult!.id! +
                      " | " +
                      postResult!.name! +
                      " | " +
                      postResult!.job! +
                      " | " +
                      postResult!.created!
                  : "Tidak Ada"),
              ElevatedButton(
                onPressed: () {
                  PostResult.connectToAPI("Wahyu", "Tidru").then((value) {
                    postResult = value;
                    setState(() {});
                  });
                },
                child: Text("Post"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
