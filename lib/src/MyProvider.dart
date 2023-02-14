import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ingorala/ObjectBox.dart';
import 'package:ingorala/contacts.dart';
import 'package:ingorala/src/models/conversation.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:objectbox/objectbox.dart';
class MyProvider extends GetxController
{
 static ObjectBox? objectbox;

   SharedPreferences? prefs;
   RxList<contacts> contactList=<contacts>[].obs;
  RxList<contacts> tempcontactList=<contacts>[].obs;

   RxList<contacts> searchcontactList=<contacts>[].obs;
  RxList<contacts> searchtempcontactList=<contacts>[].obs;

  RxList<contacts> favcontactList=<contacts>[].obs;
  RxList<contacts> favtempcontactList=<contacts>[].obs;

   RxInt currentTab = 3.obs;
   RxInt totalcontacts = 0.obs;
   RxInt selectedTab = 3.obs;
   RxString currentTitle = 'Alphabet wise Contacts'.obs;
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
     objectbox = await ObjectBox.create();
     List<contacts>? tags = objectbox?.contactbox.getAll();
     if(result == ConnectivityResult.none)
     {
       print("No internet connection");
       print("box==$tags");
       contactList.value=tags!;
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
         print("box==$tags");
         if(tags!.length==0 || tags.length!=totalcontacts.value)
           {
             list.forEach((element) {
               contacts c=contacts.fromJson(element);
               tags.forEach((element) {
                  if(tags.length==0)
                    {
                      c.favourite=0;
                    }
                  else
                    {
                      c.favourite=element.favourite;
                    }
               });
               objectbox?.contactbox.put(c);
             });
           }

         contactList.value=tags;
         tempcontactList=contactList;

         return contactList.value;
       }
  }

}