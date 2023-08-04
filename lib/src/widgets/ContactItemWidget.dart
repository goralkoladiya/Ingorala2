import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:ingorala/src/MyProvider.dart';
import 'package:ingorala/src/models/MemberModal.dart';
import 'package:ingorala/src/models/conversation.dart';
import 'package:ingorala/src/screens/account.dart';
import 'package:ingorala/src/widgets/DetailsWidget.dart';

import '../../config/ui_icons.dart';
import '../models/conversation.dart' as model;

import 'package:flutter/material.dart';

class ContactItemWidget extends StatefulWidget {
  Result message;
  ContactItemWidget(this.message);
  @override
  _ContactItemWidgetState createState() => _ContactItemWidgetState();
}

class _ContactItemWidgetState extends State<ContactItemWidget> {
  MyProvider m=MyProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.ref('ServerUrl').ref;
    Stream<DatabaseEvent> stream = ref.onValue;
    stream.listen((DatabaseEvent event) {
      Map<dynamic,dynamic> data = event.snapshot.value as Map<dynamic,dynamic>;
      m.serverUrl.value=data['url'];

    });
  }
  // print("${m.serverUrl}");
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: Duration(seconds: 1),
      closedBuilder: (context, action) {
        return Container(
          color:  Color(0xffFCFFE7).withOpacity(0.15),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child:widget.message.image!=null?Obx(() => CachedNetworkImage(
                      imageUrl: "${m.serverUrl.value}/${this.widget.message.image}",
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
                    )):CircleAvatar(
                      backgroundImage: AssetImage("img/profile.png"),
                    ),
                  ),

                ],
              ),
              SizedBox(width: 15),

              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // Text(m.serverUrl.value),
                    Text(
                      "${this.widget.message.fullName}",
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      "${this.widget.message.engName}",
                      overflow: TextOverflow.ellipsis,
                      // maxLines: 2,
                      style: Theme.of(context).textTheme.caption!.merge(
                          TextStyle(fontWeight:  FontWeight.w600)),
                    ),
                    Text(
                      "${this.widget.message.city}",
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ), Row(
                      children: [
                        Text(
                          "${this.widget.message.contact1}",
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        (this.widget.message.contact2!="" &&  this.widget.message.contact2!="0")?
                        Text(
                          " / ${this.widget.message.contact2}",
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ):SizedBox(),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
      openBuilder: (context, action) {
        return DetailsWidget(message: widget.message);
      },
    );
  }
}
