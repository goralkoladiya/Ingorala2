import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(Home());
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => new _HomeState();

}

class _HomeState extends State<Home>{

  final List<String>listof=["Pipa 1","Pipa 2","Pipa 3","Pipa 4"];

  @override
  Widget build(BuildContext context){
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Legend",
          style: new TextStyle(fontSize: 19.0),
        ),
        backgroundColor: Colors.blue,

        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add), 
            onPressed: () => debugPrint("Add"),
            ),
          new IconButton(
            icon: new Icon (Icons.add),
            onPressed: () => debugPrint("Add"),)  
        ],
      ),
      body: new Container(
        child: new ListView.builder(
          itemBuilder : (_,int index) => listDataItem(this.listof[index]),
          itemCount: this.listof.length,
        )
      ),

    );
  }
}

class listDataItem extends StatelessWidget{
  
  String itemName;
  listDataItem(this.itemName);

  @override
  Widget build(BuildContext context){
    return new Card(

      elevation: 7.0,


      child: new Container(

      margin: EdgeInsets.all(9.0),
      padding: EdgeInsets.all(6.0),

        child: new Row(
          children: <Widget>[

            new CircleAvatar(
              child: new Text(itemName[0]),
              backgroundColor: Colors.blueGrey,
              ),
              new Padding(padding: EdgeInsets.all(8.0)),
              new Text(itemName,style: TextStyle(fontSize: 20.0),)
          ]
        ),
        ),
    );
  }
}