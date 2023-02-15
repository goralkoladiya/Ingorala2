import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/ui_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:http/http.dart' as http;
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
                      MaterialButton(
                        onPressed: _submit,
                        child: Text(
                          'Save',
                          style: TextStyle(color: Theme.of(context).accentColor),
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
        TextStyle(color: Theme.of(context).focusColor),
      ),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor)),
      // hasFloatingPlaceholder: true,
      labelStyle: Theme.of(context).textTheme.bodyLarge!.merge(
        TextStyle(color: Theme.of(context).hintColor),
      ),
    );
  }

  Future<void> _submit() async {

    print(address);
    print(home_address);
    print(contact2);
    print(business);
    print(b_address);

    String apiURL = "https://ingoralajagani.cdmi.in/updatedetails.php";
    var apiResult = await http.post(Uri.parse(apiURL),body: {"address":address,"home_address":home_address,
      "contact2":contact2,"business":business,"b_address":b_address,"id":id});
    Map m=jsonDecode(apiResult.body);
    print(m);
    if(m['result']=="updated")
    {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('address', address);
      await prefs.setString('home_address',home_address);
      await prefs.setString('contact2', contact2);
      await prefs.setString('business',business);
      await prefs.setString('b_address', b_address);
      Navigator.pop(context);
      Navigator.of(context).pushNamed('/Profile');
    }
  }
}
