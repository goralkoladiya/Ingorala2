

import 'dart:convert';

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

  @override
  Widget build(BuildContext context) {
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
                      if(t1.text.length!=0)
                        {
                          m.contactList.value=m.tempcontactList.where((element) =>
                              element.e_name.toString().toLowerCase().contains(t1.text.toLowerCase())).toList();
                        }
                      else
                        {
                          m.contactList.value=m.tempcontactList.value;
                        }
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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 7),
            child: Obx(() => Column(
              children: <Widget>[
                ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shrinkWrap: true,
                  primary: false,
                  itemCount:m.contactList.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 7);
                  },
                  itemBuilder: (context, index) {
                    return MessageItemWidget(m.contactList[index],);
                  },
                ),
                Offstage(
                  offstage:m.contactList.isNotEmpty,
                  child: EmptyMessagesWidget(),
                )

              ],
            )),
          ),
        ),
      ],
    );
  }
}




