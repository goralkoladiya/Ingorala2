import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
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
  get() async {
    final prefs = await SharedPreferences.getInstance();

    print("==>${prefs.containsKey("id")}");
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
      String img =prefs.getString("image")??"";
      // String img ="profile/profile.png";
      m.offimage.value =prefs.getString("offimage")??"";
    print("img=${m.offimage.value}");
      if(m.offimage.value=="")
      {
        try {
          var imageId = await ImageDownloader.downloadImage("https://ingoralajagani.cdmi.in/${img}");
          if (imageId == null) {
            return;
          }
          m.offimage.value = (await ImageDownloader.findPath(imageId))!;
          print("path=${m.offimage.value}");
          await prefs.setString('offimage', m.offimage.value);
        } on PlatformException catch (error) {
        }
      }
      m.getContacts().then((value) {
        print("splash=$value");
        if(value.length>0)
        {
          Navigator.of(context).pushReplacementNamed('/Tabs', arguments: 2);
        }
      });
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
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text("Welcome to Ingorala"),
      ),
    );
  }
}

