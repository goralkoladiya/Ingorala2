import 'dart:convert';

  
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/ui_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:http/http.dart' as http;
import '../../config/app_config.dart';
import '../MyProvider.dart';
class ProfileSettingsDialog extends StatefulWidget {

  @override
  _ProfileSettingsDialogState createState() => _ProfileSettingsDialogState();
}

class _ProfileSettingsDialogState extends State<ProfileSettingsDialog> {
  GlobalKey<FormState> _profileSettingsFormKey =    GlobalKey<FormState>();
  String id="";
  String name="";
  String address="";
  String e_name="";
  String home_address="";
  String contact="";
  String contact2="";
  String business="";
  String b_address="";
  String image="";
  MyProvider m1 = Get.find();
  getdata() async {
    final prefs = await SharedPreferences.getInstance();
    id=prefs.getString("id")??"";
    name=prefs.getString("name")??"";
    address=prefs.getString("address")??"";
    e_name=prefs.getString("e_name")??"";
    contact=prefs.getString("contact")??"";
    contact2=prefs.getString("contact2")??"";
    home_address=prefs.getString("home_address")??"";
    b_address=prefs.getString("b_address")??"";
    business=prefs.getString("business")??"";
    image=prefs.getString("image")??"";
    setState(() {
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    // print(m1.key.value);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return SimpleDialog(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                title: Row(
                  children: <Widget>[
                    Icon(UiIcons.user_1),
                    SizedBox(width: 10),
                    Text(
                      'Profile Settings',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
                children: <Widget>[
                  Form(
                    key: _profileSettingsFormKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            cursorColor:Theme.of(context).hintColor,
                            style: TextStyle(color: Theme.of(context).hintColor),
                            keyboardType: TextInputType.text,
                            decoration: getInputDecoration(hintText: 'Enter City', labelText: 'City',),
                            initialValue:  address,
                            onChanged: (input) {
                              setState(() {
                                address = input;
                              });
                            }
                        ),
                        TextFormField(
                          maxLines: 3,
                          cursorColor:Theme.of(context).hintColor,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.emailAddress,
                          decoration: getInputDecoration(hintText: 'Enter Address', labelText: 'Enter Address'),
                          initialValue:  home_address,
                          onChanged: (input) {
                            setState(() {
                              home_address = input;
                            });
                          },
                        ),
                        TextFormField(
                          cursorColor:Theme.of(context).hintColor,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.emailAddress,
                          decoration: getInputDecoration(hintText: 'Enter Another Contact', labelText: 'Enter Another Contact'),
                          initialValue:  contact2,
                          onChanged: (input){
                            setState(() {
                              contact2 = input;
                            });
                          },
                        ),
                        TextFormField(
                          cursorColor:Theme.of(context).hintColor,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.emailAddress,
                          decoration: getInputDecoration(hintText: 'Enter Business Address', labelText: 'Enter Business Address'),
                          initialValue:  business,
                          onChanged: (input){
                            setState(() {
                              business = input;
                            });
                          },
                        ),
                        TextFormField(
                          cursorColor:Theme.of(context).hintColor,
                          maxLines: 3,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.emailAddress,
                          decoration: getInputDecoration(hintText: 'Enter Business Address', labelText: 'Enter Business Address'),
                          initialValue:  b_address,
                          onChanged: (input){
                            setState(() {
                              b_address = input;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: _submit,
                        child: Text(
                          'Save',
                          style: TextStyle(color: Color(0xff2B3467)),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                  SizedBox(height: 10),
                ],
              );
            });
      },
      child: Text(
        "Edit",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  InputDecoration getInputDecoration({String? hintText, String? labelText}) {
    return    InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.bodyLarge!.merge(
        TextStyle(color: Color(0xff2B3467)),
      ),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor)),
      // hasFloatingPlaceholder: true,
      labelStyle: Theme.of(context).textTheme.bodyLarge!.merge(
        TextStyle(color: Color(0xff2B3467)),
      ),
    );
  }

  Future<void> _submit() async {

    String apiURL = "https://ingoralajagani.cdmi.in/updatedetails.php";
    var apiResult = await http.post(Uri.parse(apiURL),body: {"address":address,"home_address":home_address,
      "contact2":contact2,"business":business,"b_address":b_address,"id":id});
    Map m=jsonDecode(apiResult.body);
    if(m['result']=="updated")
    {
      DatabaseReference ref = FirebaseDatabase.instance.ref('users').child(m1.key.value);
      await ref.update({"address":address,"home_address":home_address,
        "contact2":contact2,"business":business,"b_address":b_address});
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('address',address);
      await prefs.setString('home_address', home_address);
      await prefs.setString('contact2', contact2);
      await prefs.setString('business', business);
      await prefs.setString('b_address', b_address);

      m1.address.value=prefs.getString("address")??"";
      m1.contact2.value=prefs.getString("contact2")??"";
      m1.home_address.value=prefs.getString("home_address")??"";
      m1.b_address.value=prefs.getString("b_address")??"";
      m1.business.value=prefs.getString("business")??"";
      m1.currentTab.value = 1;
      m1.currentTitle.value = 'Profile';
      Navigator.pop(context);

    }
  }
}
