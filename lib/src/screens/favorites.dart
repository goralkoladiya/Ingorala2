import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../../config/ui_icons.dart';

import '../MyProvider.dart';
import '../models/conversation.dart';
import '../widgets/EmptyFavoritesWidget.dart';
import '../widgets/EmptyMessagesWidget.dart';
import '../widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'FavItemWidget.dart';

class FavoritesWidget extends StatefulWidget {
  @override
  _FavoritesWidgetState createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
  MyProvider m=Get.put(MyProvider());
  TextEditingController t1=TextEditingController();

  getcontacts() async {

    Database d=await MyProvider.createdatabase();
    String q1="select * from contacts where fav=1";
    List l=await d.rawQuery(q1);
    m.favcontactList.clear();
    l.forEach((element) {
      m.favcontactList.value.add(Contacts.fromJson(element));
    });
    m.tempfavcontactList=m.favcontactList;

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcontacts();
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

                      if(t1.text!=0)
                        {
                          m.favcontactList.value=m.tempfavcontactList.value.where((element) =>
                              element.e_name.toString().toLowerCase().contains(t1.text.toLowerCase())).toList();

                        }
                      else{
                        m.favcontactList.value=m.tempfavcontactList.value;
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
            child: Column(
              children: <Widget>[
               Obx(() =>  ListView.separated(
                 padding: EdgeInsets.symmetric(vertical: 15),
                 shrinkWrap: true,
                 primary: false,
                 itemCount:m.favcontactList.length,
                 separatorBuilder: (context, index) {
                   return SizedBox(height: 7);
                 },
                 itemBuilder: (context, index) {
                   return FavItemWidget(m.favcontactList[index],);
                 },
               )),
                Offstage(
                  offstage:m.favcontactList.isNotEmpty,
                  child: EmptyMessagesWidget(),
                )

              ],
            ),
          ),
        ),
      ],
    );
  }
}
