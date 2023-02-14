import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../config/ui_icons.dart';
import '../MyProvider.dart';
import '../models/route_argument.dart';

class otp extends StatefulWidget {
  // RouteArgument? routeArgument;
  Map? map;
 otp({this.map});

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  TextEditingController t1=TextEditingController();
  MyProvider m=Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  String err="";
  Widget build(BuildContext context) {

    print(widget.map!['mob']);
    print(widget.map!['ver_id']);

    final node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).hintColor.withOpacity(0.8),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 60, horizontal: 30),
                  margin: EdgeInsets.symmetric(vertical: 65, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                            offset: Offset(0, 10),
                            blurRadius: 20)
                      ]),
                  child: Column(
                    children: <Widget>[
                      Image.asset("img/logo.PNG"),
                      SizedBox(height: 10),
                      Text('Mobile No Verification',
                          style: Theme.of(context).textTheme.bodyMedium!.merge(
                            TextStyle(fontWeight: FontWeight.w600,color: Theme.of(context).focusColor,
                              fontSize: 25,),)
                      ),
                      SizedBox(height: 60),
                      OtpTextField(
                        numberOfFields: 6,
                        enabledBorderColor:Theme.of(context).focusColor.withOpacity(0.8),
                        disabledBorderColor:Theme.of(context).focusColor.withOpacity(0.8),
                        cursorColor: Theme.of(context).focusColor.withOpacity(0.8),
                        focusedBorderColor: Theme.of(context).focusColor.withOpacity(0.8),
                        borderColor: Theme.of(context).focusColor.withOpacity(0.8),
                        //set to true to show as box or false to show as dash
                        showFieldAsBox: true,
                        //runs when a code is typed in
                        onCodeChanged: (String code) {
                        },
                        //runs when every textfield is filled
                        onSubmit: (String verificationCode) async {

                          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.map!['ver_id'], smsCode: verificationCode);
                          // Sign the user in (or link) with the credential
                           auth.signInWithCredential(credential).then((value) async {
                            if(value!=null)
                              {
                                String apiURL = "https://ingoralajagani.cdmi.in/checkmobile.php";
                                var apiResult = await http.post(Uri.parse(apiURL),body: {"mobile":widget.map!['mob']});
                                if (apiResult.statusCode == 200) {
                                  Map _data = await jsonDecode(apiResult.body);
                                  print(_data);
                                  if(_data['result']=="ok")
                                  {
                                    Map map=_data['data'];
                                    final prefs = await SharedPreferences.getInstance();
                                    await prefs.setString('id', map['id']);
                                    await prefs.setString('name', map['name']);
                                    await prefs.setString('address', map['address']);
                                    await prefs.setString('e_name', map['e_name']);
                                    await prefs.setString('home_address', map['home_address']);
                                    await prefs.setString('contact', map['contact']);
                                    await prefs.setString('contact2', map['contact2']);
                                    await prefs.setString('image', map['image']);
                                    await prefs.setString('business', map['business']);
                                    await prefs.setString('b_address', map['b_address']);

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
                                    m.offimage.value =prefs.getString("offimage")??"";

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

                                    Navigator.of(context).pushNamed('/Tabs', arguments: 2);
                                  }
                                  else
                                    {
                                      err="Invalid OTP";
                                      setState(() {
                                      });
                                    }
                                } else {
                                  print(apiResult.statusCode);
                                }

                              }
                          });
                        }, // end onSubmit
                      ),

                      SizedBox(height: 50),
                      // OutlinedButton(
                      //   style: ButtonStyle(
                      //     padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12, horizontal: 70)),
                      //     backgroundColor: MaterialStateProperty.all( Theme.of(context).focusColor.withOpacity(0.8)),
                      //     foregroundColor: MaterialStateProperty.all( Colors.white),
                      //   ),
                      //   // padding:
                      //   //     EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                      //   onPressed: () async {
                      //     String mobile=t1.text;
                      //     String apiURL = "https://ingoralajagani.cdmi.in/checkmobile.php";
                      //     var apiResult = await http.post(Uri.parse(apiURL),body: {"mobile":mobile});
                      //     if (apiResult.statusCode == 200) {
                      //       Map _data = await jsonDecode(apiResult.body);
                      //       if(_data['result']=="ok")
                      //       {
                      //         Map map=_data['data'];
                      //         final prefs = await SharedPreferences.getInstance();
                      //         await prefs.setString('id', map['id']);
                      //         await prefs.setString('name', map['name']);
                      //         await prefs.setString('address', map['address']);
                      //         await prefs.setString('e_name', map['e_name']);
                      //         await prefs.setString('home_address', map['home_address']);
                      //         await prefs.setString('contact', map['contact']);
                      //         await prefs.setString('contact2', map['contact2']);
                      //         await prefs.setString('image', map['image']);
                      //         await prefs.setString('business', map['business']);
                      //         await prefs.setString('b_address', map['b_address']);
                      //
                      //
                      //         // Navigator.of(context).pushNamed('/Tabs', arguments: 2);
                      //       }
                      //       else
                      //       {
                      //         err="For login Contact to 8989898989 This Number";
                      //         setState(() {
                      //
                      //         });
                      //       }
                      //     } else {
                      //       print(apiResult.statusCode);
                      //     }
                      //   },
                      //   child: Text(
                      //       'Login',
                      //       style: TextStyle(fontWeight: FontWeight.w300 )
                      //   ),
                      //   // color: Colors.blue,
                      //   // shape: StadiumBorder(),
                      // ),
                      Text('$err',
                          style: Theme.of(context).textTheme.bodyMedium!.merge(
                            TextStyle(fontWeight: FontWeight.w600,color: Theme.of(context).focusColor,
                              fontSize: 15,),)
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
