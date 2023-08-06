import 'dart:convert';
import 'dart:collection';
import 'dart:developer';
import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ingorala/config/ui_icons.dart';

import 'package:http/http.dart' as http;
import 'package:ingorala/src/MyProvider.dart';
import 'package:ingorala/src/models/MemberModal.dart';
import 'package:ingorala/src/models/conversation.dart';
import 'package:ingorala/src/widgets/ContactItemWidget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sqflite/sqflite.dart';
import '../models/conversation.dart' as model;
import '../widgets/EmptyMessagesWidget.dart';
import '../widgets/MessageItemWidget.dart';
import '../widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import '../../config/app_config.dart' as config;
class MessagesWidget extends StatefulWidget {


  @override
  State<MessagesWidget> createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {

  MyProvider m=Get.put(MyProvider());
  TextEditingController t1=TextEditingController();
  String searchtxt="";
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('AllContacts').ref;
  List<Result> allmembers=[];
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
                          print(searchtxt);
                        },
                        controller: t1,
                        cursorColor:  Theme.of(context).hintColor,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Search Via Mobile No or Name',
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
                  return Center(
                    child: CircularProgressIndicator(color: Color(0xff2D6064)),
                  );
                }
                if(snapshot.hasData)
                {
                  Map<dynamic,dynamic> data = snapshot.data!.snapshot.value as Map<dynamic,dynamic>;
                  data = SplayTreeMap.from(
                      data, (key1, key2) => data[key1]!['eng_name'].toString().compareTo(data[key2]!['eng_name'].toString()));
                  allmembers=[];
                  data.forEach((key, value) {
                   Result r=Result.fromJson(value);
                   allmembers.add(r);
                  });
                  return Column(
                              children: [
                                Expanded(
                                  child: AlphabetScrollView(
                                    list:allmembers.map((e) {
                                      return AlphaModel(e.engName.toString());
                                    }).toList(),
                                    // isAlphabetsFiltered: false,
                                    alignment: LetterAlignment.right,
                                    itemExtent: 120,
                                    unselectedTextStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: config.Colors().textSecondeColor(1)
                                    ),
                                    selectedTextStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: config.Colors().textMainColor(1)
                                    ),
                                    overlayWidget: (value) => Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 50,
                                          color: Colors.red,
                                        ),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            // color: Theme.of(context).primaryColor,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '$value'.toUpperCase(),
                                            style: TextStyle(fontSize: 18, color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    itemBuilder: (p0, p1, p2) {
                                      if(searchtxt!="")
                                      {
                                        if(allmembers[p1].fullName!.toUpperCase().contains(searchtxt.toUpperCase()) ||
                                            allmembers[p1].engName!.toUpperCase().contains(searchtxt.toUpperCase()) ||
                                            allmembers[p1].contact1!.toUpperCase().contains(searchtxt.toUpperCase()) ||
                                            allmembers[p1].contact2!.toUpperCase().contains(searchtxt.toUpperCase()))
                                        {
                                          return  ContactItemWidget(allmembers[p1]);
                                        }
                                        else
                                        {
                                          return SizedBox();
                                        }
                                      }
                                      else{
                                        return  ContactItemWidget(allmembers[p1]);
                                      }
                                    },
                                  ),
                                )
                              ],
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
