import 'dart:convert';

  
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ingorala/src/models/BusinessList.dart';
import 'package:ingorala/src/models/CityList.dart';
import 'package:ingorala/src/models/ImpContactList.dart';
import 'package:ingorala/src/models/MemberModal.dart';
import 'package:ingorala/src/models/SurnameList.dart';
import 'package:ingorala/src/models/conversation.dart';
import 'package:ingorala/src/screens/AdvBannerScreen.dart';
import 'package:ingorala/src/screens/CityList.dart';
import 'package:ingorala/src/screens/GalleryScreen.dart';
import 'package:ingorala/src/screens/ImpContacts.dart';
import 'package:ingorala/src/screens/developerDetails.dart';
import 'package:ingorala/src/screens/surnameList.dart';
import 'package:ingorala/src/screens/favorites.dart';
import 'package:ingorala/src/screens/AllContacts.dart';
import 'package:ingorala/src/screens/notifications.dart';
import 'package:ingorala/src/screens/profilepage.dart';
import 'package:ingorala/src/screens/businessCategory.dart';
import 'package:path/path.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'models/AdvBannerList.dart';
import 'models/GalleryList.dart';
class MyProvider extends GetxController {
  List<Widget> currentPage = [
    NotificationsWidget(), //0
    ProfileWidget(),  //1
    surname(),  //2
    MessagesWidget(), //3
    businessCategory(), //4
    CityListPage(), //5
    GalleryScreen(), //6,
    ImpContactScreen(), //7
    AdvBannerScreen(), //8
    developerDetails(), //9
  ];
  RxString serverUrl="".obs;
  int _searchIndex = 0;
  Members? memberModal;
  SurnameList? surnameList;
  ImpContactList? impContactList;
  BusinessList? businessList;
  CityList? cityList;
  GalleryList? galleryList;
  AdvBannerList? advBannerListResult;
  List developerarealist= [
    "Head Office - Varachha",
    "Branch 1 - Katargam",
    "Branch 2 - Mota Varachha",
    "Branch 3 - Adajan"
  ];
  List developeraddlist= [
    "401-404, 4th Floor, City Center Complex, Nr. Yogichowk, Varachha, Surat - 395006.",
    "324-327, 3rd Floor, Laxmi Enclave - 1, Opp. Gajera School, Katargam, Surat - 395004.",
    "B 201-203, 2nd Floor, Aditya Complex, VIP Circle, Utran, Mota Varachha, Surat-395006",
    "UG-1/2, 1st Floor, V3 Corner, Honey Park Rd, Opp. 9 Square, L.P. Savani Road, Adajan, Surat-395009"
  ];

  getUrl()
  {
    DatabaseReference ref = FirebaseDatabase.instance.ref('ServerUrl').ref;
    Stream<DatabaseEvent> stream = ref.onValue;
    stream.listen((DatabaseEvent event) {
      Map<dynamic,dynamic> data = event.snapshot.value as Map<dynamic,dynamic>;
      serverUrl.value=data['url'];
      print("serverUrl=$serverUrl");
      getBusiness();
      getCityList();
      getAllSurname();
      getAllImages();
      getImpContacts();
      getAdvBannerList();
    });

  }

  Future<Members?> getAllContacts() async {
    var url = Uri.parse('$serverUrl/getallcontacts.php');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map<String,dynamic> m=jsonDecode(response.body);
    List l=m['result'];
    print("sql length=${l.length}");
    // DatabaseReference ref = FirebaseDatabase.instance.ref("AllContacts");
    // l.forEach((element) async {
    //   await ref.push().set(element);
    // });
    memberModal=Members.fromJson(m);
    return memberModal;
  }
  Future<ImpContactList?> getImpContacts() async {
    var url = Uri.parse('$serverUrl/getimpcontacts.php');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map<String,dynamic> m=jsonDecode(response.body);
    List l=m['result'];
    print("sql length=${l.length}");
    // DatabaseReference ref = FirebaseDatabase.instance.ref("ImpContacts");
    // l.forEach((element) async {
    //   await ref.push().set(element);
    // });
    impContactList=ImpContactList.fromJson(m);
    return impContactList;
  }
  Future<SurnameList?> getAllSurname() async {
    var url = Uri.parse('$serverUrl/getsurnamelist.php');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map<String,dynamic> m=jsonDecode(response.body);
    List l=m['result'];
    print("sql length=${l.length}");
    // DatabaseReference ref = FirebaseDatabase.instance.ref("SurnameList");
    // l.forEach((element) async {
    //   await ref.push().set(element);
    // });
    surnameList=SurnameList.fromJson(m);
    return surnameList;
  }
  Future<AdvBannerList?> getAdvBannerList() async {
    var url = Uri.parse('$serverUrl/getbannerimg.php');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map<String,dynamic> m=jsonDecode(response.body);
    List l=m['result'];
    print("sql length=${l.length}");
    // DatabaseReference ref = FirebaseDatabase.instance.ref("AdvBannerList");
    // l.forEach((element) async {
    //   await ref.push().set(element);
    // });
    advBannerListResult=AdvBannerList.fromJson(m);
    return advBannerListResult;
  }
  Future<GalleryList?> getAllImages() async {
    var url = Uri.parse('$serverUrl/getimages.php');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map<String,dynamic> m=jsonDecode(response.body);
    List l=m['result'];
    print("sql length=${l.length}");
    // DatabaseReference ref = FirebaseDatabase.instance.ref("SurnameList");
    // l.forEach((element) async {
    //   await ref.push().set(element);
    // });
    galleryList=GalleryList.fromJson(m);
    return galleryList;
  }
  Future<BusinessList?> getBusiness() async {
    var url = Uri.parse('$serverUrl/getbusinesslist.php');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map<String,dynamic> m=jsonDecode(response.body);
    List l=m['result'];
    print("sql length=${l.length}");
    // DatabaseReference ref = FirebaseDatabase.instance.ref("BusinessList");
    // l.forEach((element) async {
    //   await ref.push().set(element);
    // });
    businessList=BusinessList.fromJson(m);
    return businessList;

  }
  Future<CityList?> getCityList() async {
    var url = Uri.parse('$serverUrl/getcitylist.php');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map<String,dynamic> m=jsonDecode(response.body);
    List l=m['result'];
    print("sql length=${l.length}");
    // DatabaseReference ref = FirebaseDatabase.instance.ref("CityList");
    // l.forEach((element) async {
    //   await ref.push().set(element);
    // });
    cityList=CityList.fromJson(m);
    return cityList;
  }

  SharedPreferences? prefs;

  RxInt currentTab = 3.obs;
  RxInt totalcontacts = 0.obs;
  RxInt   selectedTab = 0.obs;
  RxString currentTitle = 'All Contacts'.obs;
  RxString id = "".obs;
  RxString full_name = "".obs;
  RxString eng_name = "".obs;
  RxString contact1 = "".obs;
  RxString contact2 = "".obs;
  RxString address = "".obs;
  RxString city = "".obs;
  RxString occupation = "".obs;
  RxString business_category = "".obs;
  RxString sub_occupation = "".obs;
  RxString business_address = "".obs;
  RxString image = "".obs;
  RxString status = "".obs;
  RxString key = "".obs;
  RxList<String> favlist=<String>[].obs;

}
