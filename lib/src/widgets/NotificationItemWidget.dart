import '../../config/ui_icons.dart';
import '../models/notification.dart' as model;
import 'package:flutter/material.dart';

class NotificationItemWidget extends StatefulWidget {
  NotificationItemWidget({Key? key, this.notification, this.onDismissed}) : super(key: key);
  model.Notification? notification;
  ValueChanged<model.Notification>? onDismissed;

  @override
  _NotificationItemWidgetState createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends State<NotificationItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: this.widget.notification!.read ? Colors.transparent : Theme.of(context).focusColor.withOpacity(0.15),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   height: 75,
          //   width: 75,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.all(Radius.circular(5)),
          //     // image: DecorationImage(image: AssetImage(this.widget.notification!.image), fit: BoxFit.cover),
          //   ),
          // ),
          SizedBox(width: 15),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  this.widget.notification!.notes,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyMedium!.merge(
                      // TextStyle(fontWeight: this.widget.notification!.read ? FontWeight.w300 : FontWeight.w600)),
                      TextStyle(fontWeight:  FontWeight.w600)),
                ),
                Text(
                  this.widget.notification!.date,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
