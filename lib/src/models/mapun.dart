import 'package:ingorala/src/screens/mapnit.dart';
import 'package:ingorala/src/screens/maps.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(home: MyList1()));

class MyList1 extends StatefulWidget {
  @override
  _MyList1State createState() => _MyList1State();
}

class _MyList1State extends State<MyList1> {
  List<Widget> cardList = <Widget>[];

  _addItem() {
    setState(() {
       int value = 1;
      value = value + 1;
      cardList.insert(
          0,
          GestureDetector(
            onTap: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Location()));
            },
            child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
            child: Text(
              'Peta Jaringan 1',
              style: TextStyle(fontSize: 19),
            ),
            ),
          ),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Peta Jaringan A'),
      ),
      body: CustomScrollView(
        slivers : <Widget>[
           SliverGrid(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        delegate:  SliverChildBuilderDelegate(
          (context, index) {
            return cardList[index];
          },
          childCount: cardList.length,
        ),
      ),
        ],
              ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          setState(() {
            _addItem();
          });
        },
        heroTag: "btn2",
        child: Icon(Icons.add, color: Colors.white,)
      ),
    );
  }
}


class MyList2 extends StatefulWidget {
  @override
  _MyList2State createState() => _MyList2State();
}

class _MyList2State extends State<MyList2> {
  List<Widget> cardList = <Widget>[];

  _addItem() {
    setState(() {
       int value = 1;
      value = value + 1;
      cardList.insert(
          0,
          GestureDetector(
            onTap: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Location()));
            },
            child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
            child: Text(
              'Peta Jaringan',
              style: TextStyle(fontSize: 19),
            ),
            ),
          ),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Peta Jaringan B'),
      ),
      body: CustomScrollView(
        slivers : <Widget>[
           SliverGrid(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        delegate:  SliverChildBuilderDelegate(
          (context, index) {
            return cardList[index];
          },
          childCount: cardList.length,
        ),
      ),
        ],
              ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          setState(() {
            _addItem();
          });
        },
        heroTag: "btn2",
        child: Icon(Icons.add, color: Colors.white,)
      ),
    );
  }
}

