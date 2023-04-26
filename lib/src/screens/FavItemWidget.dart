import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

import 'package:ingorala/src/models/conversation.dart';
import 'package:ingorala/src/screens/account.dart';

import '../../config/ui_icons.dart';
import '../models/conversation.dart' as model;

import 'package:flutter/material.dart';

class FavItemWidget extends StatefulWidget {
  Contacts message;
  String id;
  FavItemWidget(this.message,this.id) ;


  @override
  _FavItemWidgetState createState() => _FavItemWidgetState();
}

class _FavItemWidgetState extends State<FavItemWidget> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: Duration(seconds: 1),
      closedBuilder: (context, action) {
        return Container(
          // color: this.widget.message!.read ? Colors.transparent : Theme.of(context).focusColor.withOpacity(0.15),
          color:  Theme.of(context).focusColor.withOpacity(0.15),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: widget.message.image!="profile/profile.png"?CachedNetworkImage(
                      imageUrl: "https://ingoralajagani.cdmi.in/${this.widget.message.image}",
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
                    ):CircleAvatar(
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
                    Text(
                      "${this.widget.message.name}",
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "${this.widget.message.e_name}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.caption!.merge(
                                TextStyle(fontWeight:  FontWeight.w600)),
                          ),
                        ),
                        Text(
                          "${this.widget.message.address}",
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Text(
                      "${this.widget.message.contact}",
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
      openBuilder: (context, action) {
        return AccountWidget(widget.id,message: widget.message);
      },
    );
  }
}
