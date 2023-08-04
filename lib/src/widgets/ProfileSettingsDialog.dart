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
  String full_name="";
  String eng_name="";
  String contact1="";
  String address="";
  String contact="";
  String contact2="";
  String city="";
  String occupation="";
  String business_category="";
  String sub_occupation="";
  String business_address="";
  String image="";
  String status="";
  MyProvider m1 = Get.find();
  getdata() async {
    final prefs = await SharedPreferences.getInstance();
    id=prefs.getString("id")??"";
    full_name=prefs.getString("full_name")??"";
    eng_name=prefs.getString("eng_name")??"";
    contact1=prefs.getString("contact1")??"";
    contact2=prefs.getString("contact2")??"";
    address=prefs.getString("address")??"";
    city=prefs.getString("city")??"";
    occupation=prefs.getString("occupation")??"";
    business_category =prefs.getString("business_category")??"";
    sub_occupation =prefs.getString("sub_occupation")??"";
    business_address =prefs.getString("business_address")??"";
    image =prefs.getString("image")??"";
    status =prefs.getString("status")??"";
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
                        DropdownButtonFormField(
                          decoration: getInputDecoration(hintText: 'Select City', labelText: 'Select City'),
                          value: city.trim(),
                          items: m1.cityList!.result!.map(
                                (e) => DropdownMenuItem(child:Text("${e.gujCity}",style: TextStyle(color: Theme.of(context).hintColor)),value: e.gujCity,)).toList(), onChanged: (value) {
                          setState(() {
                            city = value!;
                          });
                        },),
                        TextFormField(
                          maxLines: 3,
                          cursorColor:Theme.of(context).hintColor,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(hintText: 'Enter Address', labelText: 'Enter Address'),
                          initialValue:  address,
                          onChanged: (input) {
                            setState(() {
                              address = input;
                            });
                          },
                        ),
                        TextFormField(
                          cursorColor:Theme.of(context).hintColor,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.phone,
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
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(hintText: 'ધંધો કે બિઝનેસ', labelText: 'ધંધો કે બિઝનેસ'),
                          initialValue:  occupation,
                          onChanged: (input){
                            setState(() {
                              occupation = input;
                            });
                          },
                        ),
                        DropdownButtonFormField(
                          decoration: getInputDecoration(hintText: 'Select Business Category', labelText: 'Select Business Category'),
                          value: business_category.trim(),
                          items: m1.businessList!.result!.map(
                                  (e) => DropdownMenuItem(child:Text("${e.category}", style: TextStyle(color: Theme.of(context).hintColor)),value: e.category,)).toList(), onChanged: (value) {
                          setState(() {
                            business_category = value!;
                          });
                        },),
                        TextFormField(
                          cursorColor:Theme.of(context).hintColor,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(hintText: 'ધંધો કે બિઝનેસ  નું નામ ', labelText: 'ધંધો કે બિઝનેસ  નું નામ '),
                          initialValue:  sub_occupation,
                          onChanged: (input){
                            setState(() {
                              sub_occupation = input;
                            });
                          },
                        ),
                        TextFormField(
                          maxLines: 3,
                          cursorColor:Theme.of(context).hintColor,
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(hintText: 'ધંધો કે બિઝનેસ  નું સરનામું ', labelText: 'ધંધો કે બિઝનેસ  નું સરનામું '),
                          initialValue:  business_address,
                          onChanged: (input){
                            setState(() {
                              business_address = input;
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
                          style: TextStyle(color: Color(0xff2D6064)),
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
        TextStyle(color: Color(0xff2D6064)),
      ),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor)),
      // hasFloatingPlaceholder: true,
      labelStyle: Theme.of(context).textTheme.bodyLarge!.merge(
        TextStyle(color: Color(0xff2D6064)),
      ),
    );
  }

  Future<void> _submit() async {
    MyProvider m1=MyProvider();
    String apiURL = "${m1.serverUrl}/updatedetails.php";
    var apiResult = await http.post(Uri.parse(apiURL),body: {
      "address":address,"occupation":occupation,
      "contact2":contact2,"business_category":business_category,
      "sub_occupation":sub_occupation,"business_address":business_address,"id":id,"city":city});
    Map m=jsonDecode(apiResult.body);
    if(m['result']=="updated")
    {
      //goral
      DatabaseReference ref = FirebaseDatabase.instance.ref('AllContacts').child(m1.key.value);
      await ref.update({"address":address,"occupation":occupation,
        "contact2":contact2,"business_category":business_category,"sub_occupation":sub_occupation,
      "business_address":business_address,"city":city});

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('address',address);
      await prefs.setString('occupation', occupation);
      await prefs.setString('contact2', contact2);
      await prefs.setString('business_category', business_category);
      await prefs.setString('sub_occupation', sub_occupation);
      await prefs.setString('business_address', business_address);
      await prefs.setString('city', city);

      m1.address.value=prefs.getString("address")??"";
      m1.occupation.value=prefs.getString("occupation")??"";
      m1.contact2.value=prefs.getString("contact2")??"";
      m1.business_category.value=prefs.getString("business_category")??"";
      m1.sub_occupation.value=prefs.getString("sub_occupation")??"";
      m1.business_address.value=prefs.getString("business_address")??"";
      m1.city.value=prefs.getString("city")??"";
      m1.currentTab.value = 1;
      m1.currentTitle.value = 'Profile';
      Navigator.pop(context);

    }
  }
}
