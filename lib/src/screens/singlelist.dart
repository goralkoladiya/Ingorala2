

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ingorala/config/ui_icons.dart';

import 'package:http/http.dart' as http;
import 'package:ingorala/src/MyProvider.dart';
import 'package:ingorala/src/models/conversation.dart';
import 'package:ingorala/src/widgets/ProfileSettingsDialog.dart';
import 'package:sqflite/sqflite.dart';
import '../models/conversation.dart' as model;
import '../widgets/EmptyMessagesWidget.dart';
import '../widgets/MessageItemWidget.dart';
import '../widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
class SingleList extends StatefulWidget {

  @override
  State<SingleList> createState() => _SingleListState();
}

class _SingleListState extends State<SingleList> {

  MyProvider m=Get.put(MyProvider());
  TextEditingController t1=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Contacts",style: Theme.of(context).textTheme.displayLarge,),
      ),
      body: Column(
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
                        print("hh");
                        if(t1.text.length>0)
                        {
                          m.searchcontactList.value=m.searchtempcontactList.where((element) =>
                              element.eName.toString().toLowerCase().contains(t1.text.toLowerCase())).toList();
                        }
                        setState(() {});
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
                    itemCount:m.searchcontactList.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 7);
                    },
                    itemBuilder: (context, index) {
                      return MessageItemWidget(m.searchcontactList[index],);
                    },
                  ),
                  Offstage(
                    offstage:m.searchcontactList.isNotEmpty,
                    child: EmptyMessagesWidget(),
                  )

                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}




