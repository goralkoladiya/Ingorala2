import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:image_downloader/image_downloader.dart';
import 'package:ingorala/src/MyProvider.dart';
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
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("id"))
    {
      m.id.value=prefs.getString("id")??"";
      m.name.value=prefs.getString("name")??"";
      m.address.value=prefs.getString("address")??"";
      m.e_name.value=prefs.getString("e_name")??"";
      m.contact.value=prefs.getString("contact")??"";
      m.contact2.value=prefs.getString("contact2")??"";
      m.home_address.value=prefs.getString("home_address")??"";
      m.b_address.value=prefs.getString("b_address")??"";
      m.business.value=prefs.getString("business")??"";
      m.image.value =prefs.getString("image")??"";
    // print("img=${m.offimage.value}");

      DatabaseReference ref = FirebaseDatabase.instance.ref('users').ref;
      Stream<DatabaseEvent> stream = ref.onValue;
      stream.listen((DatabaseEvent event) {
        Map<dynamic,dynamic> data = event.snapshot.value as Map<dynamic,dynamic>;
        data.forEach((key, value) {
          Map map=value;
          if(value['e_name'].toString()==m.e_name.value)
            {
              m.key.value=key;
            }
        });
      });
      Navigator.of(context).pushReplacementNamed('/Tabs', arguments: 2);
    }
    else{
      Navigator.of(context).pushReplacementNamed('/SignIn');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // get();
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

