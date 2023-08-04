import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:image_downloader/image_downloader.dart';
import 'package:ingorala/src/MyProvider.dart';
import 'package:ingorala/src/models/BusinessList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/signin.dart';


import 'package:ingorala/src/models/conversation.dart';
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  MyProvider m=Get.put(MyProvider());
  StreamSubscription? internetconnection;
  bool isoffline = false;
  get() async {
    m.getUrl();
    // await m.getBusiness();
    // await m.getCityList();
    // await m.getAllSurname();
    // await m.getAllImages();
    // await m.getImpContacts();
    // await m.getAdvBannerList();
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("id"))
    {
      m.id.value=prefs.getString("id")??"";
      m.full_name.value=prefs.getString("full_name")??"";
      m.eng_name.value=prefs.getString("eng_name")??"";
      m.contact1.value=prefs.getString("contact1")??"";
      m.contact2.value=prefs.getString("contact2")??"";
      m.contact2.value=prefs.getString("contact2")??"";
      m.address.value=prefs.getString("address")??"";
      m.city.value=prefs.getString("city")??"";
      m.occupation.value=prefs.getString("occupation")??"";
      m.business_category.value =prefs.getString("business_category")??"";
      m.sub_occupation.value =prefs.getString("sub_occupation")??"";
      m.business_address.value =prefs.getString("business_address")??"";
      m.image.value =prefs.getString("image")??"";
      m.status.value =prefs.getString("status")??"";
      if(m.status.value=="1")
      {
        DatabaseReference ref = FirebaseDatabase.instance.ref('AllContacts').ref;
        Stream<DatabaseEvent> stream = ref.onValue;
        stream.listen((DatabaseEvent event) {
          Map<dynamic,dynamic> data = event.snapshot.value as Map<dynamic,dynamic>;
          data.forEach((key, value) {
            print(value);
            Map map=value;
            if(value['eng_name'].toString()==m.eng_name.value)
            {
              m.key.value=key;
            }
          });
        });
        Navigator.of(context).pushReplacementNamed('/Tabs', arguments: 2);
      }
    }
    else{
      Navigator.of(context).pushReplacementNamed('/SignIn');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    // m.getAllContacts();
    internetconnection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if(result == ConnectivityResult.none){
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      }else if(result == ConnectivityResult.mobile){
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
        get();
      }else if(result == ConnectivityResult.wifi){
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
        get();
      }
    }); // using this listiner, you can get the medium of connection as well.

  }
  @override
  dispose() {
    super.dispose();
    internetconnection!.cancel();
    //cancel internent connection subscription after you are done
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: !isoffline?Center(
        child: CircularProgressIndicator(
          semanticsLabel: "Fetching Contacts",
          color: Theme.of(context).focusColor,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
        ),
      ):Center(
        child: Text("No Internet Connection"),
      ),
    );
  }
}

