import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/ui_icons.dart';
import '../MyProvider.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DrawerWidget extends StatefulWidget {
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  MyProvider m = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.ref('ServerUrl').ref;
    Stream<DatabaseEvent> stream = ref.onValue;
    stream.listen((DatabaseEvent event) {
      Map<dynamic,dynamic> data = event.snapshot.value as Map<dynamic,dynamic>;
      m.serverUrl.value=data['url'];

    });
  }
  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).hintColor.withOpacity(0.1),
            ),
            accountName: Obx(() => Text(
                  m.full_name.value,
                  style: Theme.of(context).textTheme.titleMedium,
                )),
            accountEmail: Obx(() => Text(
                  m.contact1.value,
                  style: Theme.of(context).textTheme.caption,
                )),
            currentAccountPicture: SizedBox(
              width: 90,
              height: 90,
              child: InkWell(
                  borderRadius: BorderRadius.circular(300),
                  child: Obx(() => CircleAvatar(
                    backgroundImage: NetworkImage("${m.serverUrl.value}/${m.image.value}"),
                  ),)),
            )

          ),
          ListTile(
            onTap: () {
              m.currentTab.value = 1;
              // m.selectedTab.value = 1;
              // m.currentTitle.value = 'પ્રોફાઈલ';
              m.currentTitle.value = 'Profile';
              Navigator.pop(context);
              // Navigator.of(context).pushNamed('/Tabs', arguments: 0);
            },
            leading: Icon(
              UiIcons.user_1,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "પ્રોફાઈલ",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),



          ListTile(
            onTap: () {
              m.currentTab.value = 3;
              m.selectedTab.value = 0;
              // m.currentTitle.value = 'કોન્ટેક્ટ';
              m.currentTitle.value = 'All Contacts';
              Navigator.pop(context);
              // Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            },
            leading: Icon(
              Icons.sort_by_alpha,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "કોન્ટેક્ટ",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          ListTile(
            onTap: () {
              m.currentTab.value = 7;
              m.selectedTab.value = 0;
              // m.currentTitle.value = 'કોન્ટેક્ટ';
              m.currentTitle.value = 'Imp Contacts';
              Navigator.pop(context);
              // Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            },
            leading: Icon(
              Icons.sort_by_alpha,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "અગત્યના કોન્ટેક્ટ",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          ListTile(
            onTap: () {
              m.currentTab.value = 8;
              m.selectedTab.value = 0;
              // m.currentTitle.value = 'કોન્ટેક્ટ';
              m.currentTitle.value = 'Advertisements';
              Navigator.pop(context);
              // Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            },
            leading: Icon(
              Icons.account_balance_wallet_outlined,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "જાહેરાત",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     m.currentTab.value = 3;
          //     m.selectedTab.value = 2;
          //     m.currentTitle.value = 'Surname List';
          //     Navigator.pop(context);
          //     // Navigator.of(context).pushNamed('/Tabs', arguments: 1);
          //   },
          //   leading: Icon(
          //     Icons.list_alt,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "અટક",
          //     style: Theme.of(context).textTheme.displayMedium,
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     m.currentTab.value = 5;
          //     m.selectedTab.value = 1;
          //     m.currentTitle.value = 'City List';
          //     Navigator.pop(context);
          //     // Navigator.of(context).pushNamed('/Tabs', arguments: 1);
          //   },
          //   leading: Icon(
          //     UiIcons.map,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "શહેરો",
          //     style: Theme.of(context).textTheme.displayMedium,
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     m.currentTab.value = 4;
          //     m.selectedTab.value = 3;
          //     m.currentTitle.value = 'Business List';
          //     Navigator.pop(context);
          //     // Navigator.of(context).pushNamed('/Tabs', arguments: 1);
          //   },
          //   leading: Icon(
          //     UiIcons.information,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "બિઝનેસ",
          //     style: Theme.of(context).textTheme.displayMedium,
          //   ),
          // ),
          ListTile(
            onTap: () {
              m.currentTab.value = 0;
              // m.selectedTab.value = 0;
              m.currentTitle.value = 'Notifications';
              Navigator.pop(context);
              // Navigator.of(context).pushNamed('/Categories');
            },
            leading: Icon(
              UiIcons.bell,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "નોટિફિકેશન ",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          ListTile(
            onTap: () {
              m.currentTab.value = 6;
              // m.selectedTab.value = 0;
              m.currentTitle.value = 'Gallery';
              Navigator.pop(context);
            },
            leading: Icon(
              Icons.photo,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "ગેલેરી ",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),


          // ),

          ListTile(
            dense: true,
            title: Text(
              "Application Preferences",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
          ListTile(
            onTap: () {
              m.currentTab.value = 9;
              // m.selectedTab.value = 0;
              m.currentTitle.value = 'Developer Details';
              Navigator.pop(context);
            },
            leading: Icon(
              Icons.photo,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Developer Details",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          ListTile(
            onTap: () {
              Share.share('check out my village app by downloading this url: https://play.google.com/store/apps/details?id=com.ingorala.jagani');
            },
            leading: Icon(
              Icons.share,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Share App",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          ListTile(
            onTap: () async {
               InAppReview inAppReview = InAppReview.instance;
              if (await inAppReview.isAvailable()) {

              inAppReview.requestReview();
              }
            },
            leading: Icon(
              Icons.rate_review_outlined,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Rate App",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          ListTile(
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.of(context).pushNamed('/SignIn');
            },
            leading: Icon(
              UiIcons.upload,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Log out",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),

        ],
      ),
    );
  }
}
