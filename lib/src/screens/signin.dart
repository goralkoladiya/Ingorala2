import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  bool process = false;
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
      backgroundColor: Color(0xff2D6064).withOpacity(0.7),
      body: !isoffline?Center(
        child: SingleChildScrollView(
          child:  Container(
            width: double.infinity,
            // height: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 60, horizontal: 30),
            margin: EdgeInsets.symmetric(vertical: 65, horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xff2D6064).withOpacity(0.2),
                      offset: Offset(0, 10),
                      blurRadius: 20)
                ]),
            child: Column(
              children: <Widget>[
                Image.asset("img/logo.png",height: 150,width: 150,),
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
                    process=true;
                    setState(() {

                    });
                    String mobile=t1.text;
                    if(t1.text.isEmpty)
                      {
                        err="Please Enter Mobile Number";
                        process=false;
                        setState(() {
                        });
                      }
                    else
                      {
                        String apiURL = "${m.serverUrl.value}/checkmobile.php";
                        var apiResult = await http.post(Uri.parse(apiURL),body: {"mobile":mobile});
                        if (apiResult.statusCode == 200) {
                          Map _data = await jsonDecode(apiResult.body);
                          // print(_data);
                          if(_data['result']=="ok")
                          {
                            Map map=_data['data'];
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('id', map['id']);
                            await prefs.setString('full_name', map['full_name']);
                            await prefs.setString('eng_name', map['eng_name']);
                            await prefs.setString('contact1', map['contact1']);
                            await prefs.setString('contact2', map['contact2']);
                            await prefs.setString('address', map['address']);
                            await prefs.setString('city', map['city']);
                            await prefs.setString('occupation', map['occupation']);
                            await prefs.setString('sub_occupation', map['sub_occupation']);
                            await prefs.setString('business_category', map['business_category']);
                            await prefs.setString('business_address', map['business_address']);
                            await prefs.setString('image', map['image']);
                            await prefs.setString('status', map['status']);

                            m.id.value=prefs.getString("id")??"";
                            m.full_name.value=prefs.getString("full_name")??"";
                            m.eng_name.value=prefs.getString("eng_name")??"";
                            m.contact1.value=prefs.getString("contact1")??"";
                            m.contact2.value=prefs.getString("contact2")??"";
                            m.address.value=prefs.getString("address")??"";
                            m.city.value=prefs.getString("city")??"";
                            m.occupation.value=prefs.getString("occupation")??"";
                            m.business_category.value =prefs.getString("business_category")??"";
                            m.sub_occupation.value =prefs.getString("sub_occupation")??"";
                            m.business_address.value =prefs.getString("business_address")??"";
                            m.image.value =prefs.getString("image")??"";
                            m.status.value =prefs.getString("status")??"";
                            // await m.getBusiness();
                            // await m.getCityList();
                            if(m.status.value=="1")
                            {
                              DatabaseReference ref = FirebaseDatabase.instance.ref('AllContacts').ref;
                              Stream<DatabaseEvent> stream = ref.onValue;
                              stream.listen((DatabaseEvent event) {
                                Map<dynamic,dynamic> data = event.snapshot.value as Map<dynamic,dynamic>;
                                data.forEach((key, value) {
                                  print("value==$value");
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
                          else
                          {
                            process=false;
                            err="${_data['result']}";
                            // err="એપ માં login થવા માટે 9879126452 / 9427280713 પર સંપર્ક કરવો ";
                            setState(() {
                            });
                          }
                        }
                        else {
                          print(apiResult.statusCode);
                        }
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
                Visibility(visible:process,child: CircularProgressIndicator(color: Color(0xff2D6064)),)
              ],
            ),
          )),
      ):Center(
        child: Text("no Internet Connection"),
      ),
    );
  }
}
