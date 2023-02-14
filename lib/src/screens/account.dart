import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:ingorala/contacts.dart';
import 'package:ingorala/src/models/conversation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/ui_icons.dart';
import '../MyProvider.dart';
import '../models/user.dart';
import '../widgets/ProfileSettingsDialog.dart';
import '../widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatefulWidget {
  contacts? message;
  AccountWidget({this.message});

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
                          widget.message!.name!,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Text(
                          widget.message!.eName!,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          "${widget.message!.favourite}",
                          style: Theme.of(context).textTheme.caption,
                        )
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
                                  // shape: BoxShape.circle,
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
                    child: widget.message!.favourite==0?TextButton(
                      // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      onPressed: () async {
                        widget.message!.favourite=1;
                        m.currentTab.value=4;
                        m.selectedTab.value=4;
                        m.currentTitle.value = 'Favorites';
                        Navigator.of(context).pushNamed('/Tabs', arguments: 4);
                        // Database d=await MyProvider.createdatabase();
                        // String q1="update contacts set fav=1 where id=${widget.message!.id}";
                        // d.rawUpdate(q1).then((value) async {
                        //   String q11="select * from contacts";
                        //   List l=await d.rawQuery(q11);
                        //   m.contactList.clear();
                        //   l.forEach((element) {
                        //     m.contactList.add(contacts.fromJson(element));
                        //   });
                        //
                        // });
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(UiIcons.heart),
                          Text(
                            'Wish List',
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                      ),
                    ):TextButton(
                      // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      onPressed: () async {
                        widget.message!.favourite=0;

                        m.currentTab.value=4;
                        m.selectedTab.value=4;
                        Navigator.of(context).pushNamed('/Tabs', arguments: 4);

                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.favorite,color: Colors.amber,),
                          Text(
                            'Wish List',
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
                  //     // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  //     onPressed: () {
                  //       Navigator.of(context).pushNamed('/Tabs', arguments: 0);
                  //     },
                  //     child: Column(
                  //       children: <Widget>[
                  //         Icon(UiIcons.favorites),
                  //         Text(
                  //           'Following',
                  //           style: Theme.of(context).textTheme.bodyLarge,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Expanded(
                  //   child: TextButton(
                  //     // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  //     onPressed: () {
                  //       Navigator.of(context).pushNamed('/Tabs', arguments: 3);
                  //     },
                  //     child: Column(
                  //       children: <Widget>[
                  //         Icon(UiIcons.chat_1),
                  //         Text(
                  //           'Messages',
                  //           style: Theme.of(context).textTheme.bodyLarge,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
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
                          widget.message!.address!,
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
                          widget.message!.homeAddress!,
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
                      widget.message!.contact!,
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
                      widget.message!.contact2!,
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
                          widget.message!.business!,
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
                          "${widget.message!.bAddress!}",
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
