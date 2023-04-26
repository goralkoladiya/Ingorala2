import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


import '../../config/ui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../config/app_config.dart' as config;
import 'package:http/http.dart' as http;

import '../MyProvider.dart';
import '../models/route_argument.dart';
class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {

  TextEditingController t1=TextEditingController();
  MyProvider m=Get.find();
  String err="";
  FirebaseAuth auth = FirebaseAuth.instance;
  StreamSubscription? internetconnection;
  bool isoffline = false;
  //set variable for Connectivity subscription listiner

  @override
  void initState() {
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
      }else if(result == ConnectivityResult.wifi){
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      }
    }); // using this listiner, you can get the medium of connection as well.

    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    internetconnection!.cancel();
    //cancel internent connection subscription after you are done
  }

  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: Color(0xff2B3467).withOpacity(0.7),
      body: !isoffline?SingleChildScrollView(
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
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff2B3467).withOpacity(0.2),
                            offset: Offset(0, 10),
                            blurRadius: 20)
                      ]),
                  child: Column(
                    children: <Widget>[
                      Image.asset("img/logo.PNG"),
                      SizedBox(height: 10),
                      Text('Sign In',
                          style: Theme.of(context).textTheme.bodyMedium!.merge(
                            TextStyle(fontWeight: FontWeight.w600,color: Theme.of(context).focusColor,
                            fontSize: 25,),)
                          ),
                      SizedBox(height: 60),
                       TextField(
                         controller: t1,
                         style: TextStyle(fontSize: 16.0, color: config.Colors().textSecondeColor(1)),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus(),
                        decoration: new InputDecoration(
                          hintText: 'Enter Mobile Number',
                          // hintStyle: Theme.of(context).textTheme.bodyLarge!.merge(,
                          //     ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: config.Colors().textSecondeColor(1))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: config.Colors().textSecondeColor(1))),
                          prefixIcon: Icon(
                            UiIcons.phone_call,
                            color: config.Colors().textSecondeColor(1),

                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      OutlinedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12, horizontal: 70)),
                          backgroundColor: MaterialStateProperty.all( Theme.of(context).focusColor.withOpacity(0.8)),
                          foregroundColor: MaterialStateProperty.all( Colors.white),
                        ),
                        // padding:
                        //     EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                        onPressed: () async {
                          String mobile=t1.text;
                          String apiURL = "https://ingoralajagani.cdmi.in/checkmobile.php";
                          var apiResult = await http.post(Uri.parse(apiURL),body: {"mobile":mobile});
                          if (apiResult.statusCode == 200) {
                            Map _data = await jsonDecode(apiResult.body);
                            // print(_data);
                            if(_data['result']=="ok")
                              {
                                await FirebaseAuth.instance.verifyPhoneNumber(
                                  phoneNumber: '+91 ${mobile}',
                                  timeout: Duration(seconds: 30),
                                  verificationCompleted: (PhoneAuthCredential credential) async {
                                    print(credential.smsCode);
                                    await auth.signInWithCredential(credential);
                                  },
                                  verificationFailed: (FirebaseAuthException e) {
                                    if (e.code == 'invalid-phone-number') {
                                      print('The provided phone number is not valid.');
                                    }
                                  },
                                  codeSent: (String verificationId, int? resendToken) {
                                    Navigator.of(context).pushReplacementNamed('/otp',arguments: {'ver_id':verificationId,'mob':mobile});
                                  },
                                  codeAutoRetrievalTimeout: (String verificationId) {

                                  },
                                );
                               }
                            else
                              {
                                err="For login Contact to 8989898989 This Number";
                                setState(() {
                                });
                              }
                          } else {
                            // print(apiResult.statusCode);
                          }
                        },
                        child: Text(
                          'Login',
                            style: TextStyle(fontWeight: FontWeight.w300 )
                        ),
                        // color: Colors.blue,
                        // shape: StadiumBorder(),
                      ),
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
      ):Center(
        child: Text("no Internet Connection"),
      ),
    );
  }
}
