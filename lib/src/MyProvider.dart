import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ingorala/src/models/conversation.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
class MyProvider extends GetxController
{
   SharedPreferences? prefs;
   RxList<Contacts> contactList=<Contacts>[].obs;
   RxList<Contacts> tempcontactList=<Contacts>[].obs;

   RxList<Contacts> favcontactList=<Contacts>[].obs;
   RxList<Contacts> tempfavcontactList=<Contacts>[].obs;

   RxList<Contacts> searchcontactList=<Contacts>[].obs;
   RxList<Contacts> searchtempcontactList=<Contacts>[].obs;

   RxInt currentTab = 3.obs;
   RxInt totalcontacts = 0.obs;
   RxInt selectedTab = 3.obs;
   RxString currentTitle = 'Contacts'.obs;
   RxString id="".obs;
   RxString name="".obs;
   RxString address="".obs;
   RxString e_name="".obs;
   RxString home_address="".obs;
   RxString contact="".obs;
   RxString contact2="".obs;
   RxString business="".obs;
   RxString b_address="".obs;
   RxString offimage="".obs;

   Future<List> getContacts() async {

     var result = await Connectivity().checkConnectivity();
     final prefs = await SharedPreferences.getInstance();

     if(result == ConnectivityResult.none)
     {
       print("No internet connection");
       Database d=await createdatabase();
       String q1="select * from contacts";
       List l=await d.rawQuery(q1);
       l.forEach((element) {
         contactList.add(Contacts.fromJson(element));
       });
       tempcontactList=contactList;
       return contactList.value;
     }
     else
       {
         String apiURL = "https://ingoralajagani.cdmi.in/getcontact.php";
         var apiResult = await http.get(Uri.parse(apiURL));
         Map map=jsonDecode(apiResult.body);
         List list = map['result'];
         totalcontacts.value=map['total'];
         await prefs.setInt('total', totalcontacts.value);
         print("online=${totalcontacts.value}");
         createdatabase().then((value) async {
           String q1="select * from contacts";
           List l=await value.rawQuery(q1);
           int total=l.length;
           if(total!=totalcontacts.value)
           {
             String q2="DELETE FROM contacts";
             await value.rawDelete(q2);
             list.forEach((element) async {
               String q="insert into contacts values(null,'${element['id']}','${element['name']}','${element['e_name']}','${element['address']}',"
                   "'${element['home_address']}','${element['contact']}','${element['contact2']}',"
                   "'${element['image']}','${element['business']}','${element['b_address']}',0)";
               await value.rawInsert(q);
             });
           }
         });

         Database d=await createdatabase();
         String q1="select * from contacts";
         List l=await d.rawQuery(q1);
         l.forEach((element) {
           contactList.add(Contacts.fromJson(element));
         });
         print(contactList.value);
         tempcontactList=contactList;
         return contactList.value;
       }
  }

 static Future<Database> createdatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE contacts (id INTEGER PRIMARY KEY,cid TEXT, name TEXT, e_name TEXT, address TEXT,'
                  '`home_address` TEXT, `contact` TEXT, `contact2` TEXT, `image` TEXT, `business` TEXT, `b_address` TEXT,fav INTEGER default 0)');
        });
    return database;

  }
}