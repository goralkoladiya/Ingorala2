import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/ui_icons.dart';
import '../MyProvider.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DrawerWidget extends StatelessWidget {
  MyProvider m = Get.find();

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
                  m.name.value,
                  style: Theme.of(context).textTheme.titleMedium,
                )),
            accountEmail: Obx(() => Text(
                  m.contact.value,
                  style: Theme.of(context).textTheme.caption,
                )),
            currentAccountPicture: SizedBox(
              width: 90,
              height: 90,
              child: InkWell(
                  borderRadius: BorderRadius.circular(300),
                  child: Obx(() => CircleAvatar(
                    backgroundImage: NetworkImage("https://ingoralajagani.cdmi.in/${m.image.value}"),
                  ),)),
            )

          ),
          ListTile(
            onTap: () {
              m.currentTab.value = 0;
              m.selectedTab.value = 0;
              m.currentTitle.value = 'Notifications';
              Navigator.pop(context);
              // Navigator.of(context).pushNamed('/Categories');
            },
            leading: Icon(
              UiIcons.bell,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Notifications",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          ListTile(
            onTap: () {
              m.currentTab.value = 1;
              m.selectedTab.value = 1;
              m.currentTitle.value = 'Profile';
              Navigator.pop(context);
              // Navigator.of(context).pushNamed('/Tabs', arguments: 0);
            },
            leading: Icon(
              UiIcons.user_1,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Profile",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          ListTile(
            onTap: () {
              m.currentTab.value = 2;
              m.selectedTab.value = 2;
              m.currentTitle.value = 'Alphabet wise Contacts';
              Navigator.pop(context);
              // Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            },
            leading: Icon(
              Icons.sort_by_alpha,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Alphabet wise Contacts",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          ListTile(
            onTap: () {
              m.currentTab.value = 3;
              m.selectedTab.value = 3;
              m.currentTitle.value = 'Contacts';
              Navigator.pop(context);
              // Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            },
            leading: Icon(
              UiIcons.home,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Contacts",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     m.currentTab.value = 4;
          //     m.selectedTab.value = 4;
          //     m.currentTitle.value = 'Favourite';
          //     Navigator.pop(context);
          //     // Navigator.of(context).pushNamed('/Tabs', arguments: 1);
          //   },
          //   leading: Icon(
          //     Icons.favorite_border,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Favourite",
          //     style: Theme.of(context).textTheme.displayMedium,
          //   ),
          // ),



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
