import 'dart:convert';
import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ingorala/config/ui_icons.dart';

import 'package:http/http.dart' as http;
import 'package:ingorala/src/MyProvider.dart';
import 'package:ingorala/src/models/conversation.dart';
import 'package:sqflite/sqflite.dart';
import '../models/conversation.dart' as model;
import '../widgets/EmptyMessagesWidget.dart';
import '../widgets/MessageItemWidget.dart';
import '../widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
class MessagesWidget extends StatefulWidget {

  @override
  State<MessagesWidget> createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {

  MyProvider m=Get.put(MyProvider());
  TextEditingController t1=TextEditingController();
  String searchtxt="";
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('users').ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    starCountRef.keepSynced(true);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 5),
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
                        onChanged: (value) {
                          setState(() {
                            searchtxt=value;
                          });
                        },
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
            ),

          ],
        ),
        Expanded(
            child: StreamBuilder<DatabaseEvent>(
              stream: starCountRef.onValue,
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

                  data = SplayTreeMap.from(
                      data, (key1, key2) => data[key1]!['e_name'].compareTo(data[key2]!['e_name']));
                  return ListView(
                      shrinkWrap: true,
                      children: data.entries.map((e) {
                        print("${e.key}==>${e.value}");
                        Contacts c=Contacts.fromJson(e.value);
                        if(searchtxt!="")
                        {
                          if(c.e_name.toUpperCase().contains(searchtxt.toUpperCase()))
                          {
                            return MessageItemWidget(c,e.key);
                          }
                          else
                          {
                            return Container();
                          }
                        }
                        else{
                          return MessageItemWidget(c,e.key);
                        }
                        // Contacts c=Contacts.fromJson(e.value);
                        // return   MessageItemWidget(c,e.key);
                      }).toList()
                  );
                }
                else
                {
                  return EmptyMessagesWidget();
                }
              },
            )
        ),
      ],
    );
  }
}



/*
  Contacts c=Contacts.fromJson(data);
                    if(searchtxt!="")
                    {
                      if(c.e_name!.toUpperCase().contains(searchtxt.toUpperCase()))
                      {
                        return MessageItemWidget(c,document.id);
                      }
                      else
                      {
                        return Container();
                      }
                    }
                    else{
                      return MessageItemWidget(c,document.id);
                    }
 */
