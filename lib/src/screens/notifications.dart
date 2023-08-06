import 'dart:convert';

import 'package:ingorala/src/MyProvider.dart';
import 'package:ingorala/src/models/notification.dart' as noti;

import '../models/notification.dart' as model;
import '../widgets/EmptyNotificationsWidget.dart';
import '../widgets/NotificationItemWidget.dart';
import '../widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class NotificationsWidget extends StatefulWidget {
  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  List<dynamic> _notificationList=[];
  MyProvider m=MyProvider();
  getNotification() async {
    m.getprofileurl();
    String apiURL = "${m.serverUrl.value}/getnotes.php";
    var apiResult = await http.get(Uri.parse(apiURL));
    var jsonObject = json.decode(apiResult.body);
    // print(jsonObject['total']);
    List list=jsonObject['result'];
    // print(list);
    _notificationList.clear();
    list.forEach((element) {
      _notificationList.add(noti.Notification.fromJson(element));
    });
    setState(() {
    });


  }
  @override
  void initState() {
    super.initState();
    getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Column(
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: SearchBarWidget(),
            // ),
            Offstage(
              offstage: _notificationList.isEmpty,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 15),
                shrinkWrap: true,
                primary: false,
                itemCount: _notificationList.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 7);
                },
                itemBuilder: (context, index) {
                  return NotificationItemWidget(
                    notification: _notificationList[index],
                    onDismissed: (notification) {
                      setState(() {
                        _notificationList.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),
            Offstage(
              offstage: _notificationList.isNotEmpty,
              child: EmptyNotificationsWidget(),
            )
          ],
        ),
      ),
    );
  }
}
