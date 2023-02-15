import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ingorala/src/models/conversation.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../config/ui_icons.dart';
import '../../main.dart';

import '../MyProvider.dart';

import '../widgets/ProfileSettingsDialog.dart';
import '../widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MyProvider m = Get.find();

  File? imageFile;
  final imgPicker = ImagePicker();
  String uploadurl = "https://ingoralajagani.cdmi.in/uploadimage.php";
  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Options"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Capture Image From Camera"),
                    onTap: () {
                      openCamera();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Take Image From Gallery"),
                    onTap: () {
                      openGallery();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void openCamera() async {
    var imgCamera = await imgPicker.getImage(source: ImageSource.camera);
    imageFile = File(imgCamera!.path);
    await uploadImage(imageFile!);
    await uploadImage(imageFile!);
  }

  void openGallery() async {
    var imgGallery = await imgPicker.getImage(source: ImageSource.gallery);
    imageFile = File(imgGallery!.path);
    await uploadImage(imageFile!);

  }

  Future<void> uploadImage(File imageFile) async {
    final prefs = await SharedPreferences.getInstance();
    try{
      List<int> imageBytes = imageFile.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      var response = await http.post(
          Uri.parse(uploadurl),
          body: {
            'image': baseimage,
            'id':m.id.value
          }
      );
      if(response.statusCode == 200){
        var jsondata = json.decode(response.body); //decode json data
        if(jsondata['msg']=="image is submited.")
        {
          m.offimage.value = imageFile.path;
          await prefs.setString('offimage', m.offimage.value);
          Navigator.of(context).pop();
        }
      }else{
        print("Error during connection to server");
      }
    }catch(e){
      print("Error during converting to Base64");
    }
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
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
                        Obx(() => Text(
                              m.name.value,
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.displayMedium,
                            )),
                        Obx(() => Text(
                              m.e_name.value,
                              style: Theme.of(context).textTheme.caption,
                            ))
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  Column(
                    children: [
                      m.offimage.value!=""
                          ? InkWell(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                        height: 300,
                                        width: 300,
                                        child: Obx(
                                          () => CircleAvatar(
                                            backgroundImage: FileImage(
                                                File(m.offimage.value)),
                                          ),
                                        ));
                                  },
                                );
                              },
                              child: Obx(() => SizedBox(
                                    width: 90,
                                    height: 90,
                                    child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(300),
                                        child: CircleAvatar(
                                          backgroundImage:
                                              FileImage(File(m.offimage.value)),
                                        )),
                                  )))
                          : Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(shape: BoxShape.circle,image: DecorationImage(
                            image: AssetImage("img/profile.png")
                        )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                          onTap: () {
                            showOptionsDialog(context);
                          },
                          child: Text("Edit"))
                    ],
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
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.15),
                      offset: Offset(0, 3),
                      blurRadius: 10)
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      onPressed: () {
                        // Navigator.of(context).pushNamed('/Tabs', arguments: 4);
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
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              children: [
                                SimpleDialogOption(
                                  child: Text(" Call",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                ),
                                SimpleDialogOption(
                                  onPressed: () async {
                                    Uri _url =
                                        Uri.parse('tel:+91 ${m.contact.value}');
                                    await UrlLauncher.launchUrl(_url);
                                  },
                                  child: Obx(() => Row(children: [
                                        Icon(
                                          UiIcons.phone_call,
                                          color: Color(0xffFC8D5F),
                                          size: 20,
                                        ),
                                        Text(" ${m.contact.value}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge)
                                      ])),
                                ),
                                m.contact2.value != ""
                                    ? SimpleDialogOption(
                                        onPressed: () async {
                                          Uri _url = Uri.parse(
                                              'tel:+91 ${m.contact2.value}');
                                          await UrlLauncher.launchUrl(_url);
                                        },
                                        child: Obx(() => Row(children: [
                                              Icon(UiIcons.phone_call,
                                                  color: Color(0xffFC8D5F),
                                                  size: 20),
                                              Text(" ${m.contact2.value}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge)
                                            ])),
                                      )
                                    : Container()
                              ],
                            );
                          },
                        );
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
                        Uri _url = Uri.parse('sms:+91 ${m.contact.value}');
                        await UrlLauncher.launchUrl(_url);
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
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.15),
                      offset: Offset(0, 3),
                      blurRadius: 10)
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
                    trailing: ButtonTheme(
                      padding: EdgeInsets.all(0),
                      minWidth: 50.0,
                      height: 25.0,
                      child: ProfileSettingsDialog(),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    title: Column(
                      children: <Widget>[
                        Text(
                          'City',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Theme.of(context).focusColor),
                        ),
                        Obx(() => Text(
                              m.address.value,
                              style: Theme.of(context).textTheme.caption,
                            ))
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
                        Obx(() => Text(
                              m.home_address.value,
                              style: Theme.of(context).textTheme.caption,
                            ))
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
                    trailing: Obx(() => Text(
                          m.contact.value,
                          style: Theme.of(context).textTheme.caption,
                        )),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      'Another Contact',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                    trailing: Obx(() => Text(
                          m.contact2.value,
                          style: Theme.of(context).textTheme.caption,
                        )),
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
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.15),
                      offset: Offset(0, 3),
                      blurRadius: 10)
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
                  m.business.value != ""
                      ? ListTile(
                          dense: true,
                          title: Column(
                            children: <Widget>[
                              Obx(() => Text(
                                    m.business.value,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor),
                                  )),
                            ],
                            // crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        )
                      : Text("-", style: Theme.of(context).textTheme.caption),
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
                        Obx(() => Text(
                              "${m.b_address.value}",
                              style: Theme.of(context).textTheme.caption,
                            ))
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
/*
CachedNetworkImage(
                            imageUrl: "https://ingoralajagani.cdmi.in/${image}",
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
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          )
 */
/*
 GestureDetector(
                          onScaleStart: (details) {
                            _previousScale = _scale;
                          },
                          onScaleUpdate: (details) {
                            setState(() => _scale = _previousScale * details.scale);
                          },
                          onScaleEnd: (details) {
                            _previousScale = 0;
                          },
                          child: Transform(
                            transform:  Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                            alignment: FractionalOffset.center,
                            child: CachedNetworkImage(
                              imageUrl: "https://ingoralajagani.cdmi.in/${image}",
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
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                        )
 */
