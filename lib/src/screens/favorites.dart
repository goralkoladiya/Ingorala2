import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../../config/ui_icons.dart';

import '../MyProvider.dart';
import '../models/conversation.dart';
import '../widgets/EmptyFavoritesWidget.dart';
import '../widgets/EmptyMessagesWidget.dart';
import '../widgets/MessageItemWidget.dart';
import '../widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';

import 'FavItemWidget.dart';

class FavoritesWidget extends StatefulWidget {
  @override
  _FavoritesWidgetState createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
  MyProvider m=Get.put(MyProvider());
  TextEditingController t1=TextEditingController();
  DatabaseReference? starCountRef;
  String searchtxt="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    starCountRef = FirebaseDatabase.instance.ref('Favourite').child('${m.key.value}').ref;
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, 4), blurRadius: 10)
              ],
            ),
            child:Column(
              children: <Widget>[
                TextField(
                  controller: t1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.8)),
                    suffixIcon: IconButton(onPressed: () {
                      
                    },icon: Icon(UiIcons.loupe, size: 20), color: Theme.of(context).hintColor),
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),

                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: StreamBuilder<DatabaseEvent>(
              stream: starCountRef!.onValue,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                if(snapshot.hasData)
                {
                  Map<dynamic,dynamic> data = snapshot.data!.snapshot.value as Map<dynamic,dynamic>;
                  print(data);
                  // data = SplayTreeMap.from(
                  //     data, (key1, key2) => data[key1]!['e_name'].compareTo(data[key2]!['e_name']));
                  return ListView(
                      shrinkWrap: true,
                      children: data.entries.map((e) {
                        print(e.value);
                        Contacts c=Contacts.fromJson(e.value);
                        if(searchtxt!="")
                        {
                          if(c.e_name.toUpperCase().contains(searchtxt.toUpperCase()))
                          {
                            return FavItemWidget(c,e.key);
                          }
                          else
                          {
                            return Container();
                          }
                        }
                        else{
                          return FavItemWidget(c,e.key);
                        }
                        // Contacts c=Contacts.fromJson(e.value);
                        // return   MessageItemWidget(c,e.key);
                      }).toList() as List<Widget>
                  );
                }
                else
                {
                  return EmptyMessagesWidget();
                }
              },
            )
        ),
        // Expanded(
        //     child: StreamBuilder<QuerySnapshot>(
        //       stream: _usersStream,
        //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //         if (snapshot.hasError) {
        //           return Text('Something went wrong');
        //         }
        //
        //         if (snapshot.connectionState == ConnectionState.waiting) {
        //           return Text("Loading");
        //         }
        //
        //         return ListView(
        //           shrinkWrap: true,
        //           children: snapshot.data!.docs.map((DocumentSnapshot document) {
        //             Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        //             Contacts c=Contacts.fromJson(data);
        //             return FavItemWidget(c,document.id);
        //           }).toList(),
        //         );
        //       },
        //     )
        // ),
      ],
    );
  }
}
