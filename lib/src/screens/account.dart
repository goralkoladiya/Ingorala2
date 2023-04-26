import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../whatsappicon.dart';
import 'package:get/get.dart';

import 'package:ingorala/src/models/conversation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/ui_icons.dart';
import '../MyProvider.dart';

import '../widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatefulWidget {
  Contacts? message;
  String id;
  AccountWidget(this.id,{this.message});

  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MyProvider m=Get.put(MyProvider());


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Details",style: Theme.of(context).textTheme.displayLarge,),

      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                         "${ widget.message!.name}",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Text(
                          "${widget.message!.e_name}",
                          style: Theme.of(context).textTheme.caption,
                        ),

                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      widget.message!.image!=null?
                      showDialog(barrierDismissible:true,context: context, builder: (context) {
                        return Container(
                            height: 300,
                            width: 300,
                            child: CachedNetworkImage(
                              imageUrl: "https://ingoralajagani.cdmi.in/${this.widget.message!.image}",
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Image.asset("img/profile.png"),
                              errorWidget: (context, url, error) => Image.asset("img/profile.png"),
                            )
                        );
                      },):
                      null;
                    },
                    child: SizedBox(
                        width: 55,
                        height: 55,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(300),
                          child: widget.message!.image!=null?CachedNetworkImage(
                            imageUrl: "https://ingoralajagani.cdmi.in/${this.widget.message!.image}",
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Image.asset("img/profile.png"),
                            errorWidget: (context, url, error) => Image.asset("img/profile.png"),
                          ):CircleAvatar(
                            backgroundImage: AssetImage("img/profile.png"),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        var contact = "+91${widget.message!.contact}";
                        var androidUrl = "whatsapp://send?phone=$contact&text=Hi";
                        var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi')}";
                        try{
                          if(Platform.isIOS){
                            await launchUrl(Uri.parse(iosUrl));
                          }
                          else{
                            await launchUrl(Uri.parse(androidUrl));
                          }
                        } on Exception{
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("WhatsApp is not installed on the device"),
                            ),
                          );
                        }
                        // Navigator.of(context).pushNamed('/Tabs', arguments: 4);
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(MyFlutterApp.whatsapp),
                          Text(
                            'Whatsapp',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      onPressed: () {
                        showDialog(context: context, builder: (context) {
                          return SimpleDialog(
                            children: [
                              SimpleDialogOption(child: Text(" Call", style: Theme.of(context).textTheme.displayMedium),),
                              SimpleDialogOption(onPressed: () async {
                                Uri _url = Uri.parse('tel:+91 ${widget.message!.contact}');
                                await launchUrl(_url);
                              },child: Row(children: [Icon(UiIcons.phone_call,color: Color(0xffFC8D5F),size: 20,),Text(" ${widget.message!.contact}", style: Theme.of(context).textTheme.bodyLarge)]),),
                              widget.message!.contact2!=""?
                              SimpleDialogOption(onPressed: () async {
                                Uri _url = Uri.parse('tel:+91 ${widget.message!.contact2}');
                                await launchUrl(_url);
                              },child: Row(children: [Icon(UiIcons.phone_call,color: Color(0xffFC8D5F),size: 20),Text(" ${widget.message!.contact2}",style: Theme.of(context).textTheme.bodyLarge)]),):Container()
                            ],
                          );
                        },);
                        // UrlLauncher.launchUrl(Uri.parse('tel:+91${contact}'));
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(UiIcons.phone_call),
                          Text(
                            'Call',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      onPressed: () async {
                        Uri _url = Uri.parse('sms:+91 ${widget.message!.contact}');
                        await launchUrl(_url);
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(UiIcons.message_2),
                          Text(
                            'Message',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: TextButton(
                  //     onPressed: () async {
                  //       final prefs = await SharedPreferences.getInstance();
                  //       DatabaseReference ref = FirebaseDatabase.instance.ref("Favourite").child('${m.key}').push();
                  //       if(!m.favlist.contains(widget.id))
                  //       {
                  //         m.favlist.add(widget.id.toString());
                  //         await prefs.setStringList('favitems', m.favlist.value);
                  //         await ref.set(widget.message!.toJson());
                  //       }
                  //       m.currentTab.value = 4;
                  //       m.selectedTab.value = 4;
                  //       m.currentTitle.value = 'Favourite';
                  //       Navigator.of(context).pushNamed('/Tabs', arguments: 0);
                  //     },
                  //     child: Column(
                  //       children: <Widget>[
                  //         Icon(Icons.favorite_border,),
                  //         Text(
                  //           'Favourite',
                  //           style: Theme.of(context).textTheme.bodyLarge,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // )

                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: <Widget>[
                  ListTile(
                    dense: true,
                    leading: Icon(UiIcons.user_1),
                    title: Text(
                      'Profile',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    // trailing: ButtonTheme(
                    //   padding: EdgeInsets.all(0),
                    //   minWidth: 50.0,
                    //   height: 25.0,
                    //   child: ProfileSettingsDialog(
                    //     user: this._user,
                    //     onChanged: () {
                    //       setState(() {});
                    //     },
                    //   ),
                    // ),
                  ),

                  ListTile(
                    dense: true,
                    title: Column(
                      children: <Widget>[
                        Text(
                          'City',
                          textAlign: TextAlign.left,
                          style:  TextStyle(color: Theme.of(context).focusColor),
                        ),
                        Text(
                          "${widget.message!.address}",
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Column(
                      children: <Widget>[
                        Text(
                          'Address',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Theme.of(context).focusColor),
                        ),
                        Text(
                          "${widget.message!.home_address}",
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      'Contact',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                    trailing: Text(
                      "${widget.message!.contact}",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      'Another Contact',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                    trailing: Text(
                      "${widget.message!.contact2}",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              padding: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: <Widget>[
                  ListTile(
                    leading: Icon(UiIcons.settings_1),
                    title: Text(
                      'Business',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  // ListTile(
                  //   onTap: () {},
                  //   dense: true,
                  //   title: Row(
                  //     children: <Widget>[
                  //       Icon(
                  //         UiIcons.placeholder,
                  //         size: 22,
                  //         color: Theme.of(context).focusColor,
                  //       ),
                  //       SizedBox(width: 10),
                  //       Text(
                  //         'Business',
                  //         style: Theme.of(context).textTheme.bodyLarge,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  widget.message!.business!=""?ListTile(
                    dense: true,
                    title: Column(
                      children: <Widget>[
                        Text(
                          widget.message!.business,
                          textAlign: TextAlign.left,
                          style:  TextStyle(color: Theme.of(context).focusColor),
                        ),
                      ],
                      // crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ):Text("-",style: Theme.of(context).textTheme.caption),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Column(
                      children: <Widget>[
                        Text(
                          'Address',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Theme.of(context).focusColor),
                        ),
                        Text(
                          "${widget.message!.b_address}",
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
