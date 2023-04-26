import 'dart:convert';

  
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ingorala/src/models/conversation.dart';
import 'package:ingorala/src/screens/alphabet.dart';
import 'package:ingorala/src/screens/favorites.dart';
import 'package:ingorala/src/screens/messages.dart';
import 'package:ingorala/src/screens/notifications.dart';
import 'package:ingorala/src/screens/profilepage.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
class MyProvider extends GetxController {
  List<Widget> currentPage = [
    NotificationsWidget(),
    ProfileWidget(),
    alphabet(),
    MessagesWidget(),
    // FavoritesWidget()
  ];

  SharedPreferences? prefs;

  RxInt currentTab = 3.obs;
  RxInt totalcontacts = 0.obs;
  RxInt selectedTab = 3.obs;
  RxString currentTitle = 'Contacts'.obs;
  RxString id = "".obs;
  RxString name = "".obs;
  RxString address = "".obs;
  RxString e_name = "".obs;
  RxString home_address = "".obs;
  RxString contact = "".obs;
  RxString contact2 = "".obs;
  RxString business = "".obs;
  RxString b_address = "".obs;
  RxString image = "".obs;
  RxString key = "".obs;
  RxList<String> favlist=<String>[].obs;

}
