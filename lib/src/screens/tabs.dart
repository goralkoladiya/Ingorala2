import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ingorala/src/MyProvider.dart';
import 'package:ingorala/src/screens/profilepage.dart';

import '../../config/ui_icons.dart';
import '../screens/account.dart';
import '../screens/favorites.dart';

import '../screens/AllContacts.dart';
import '../screens/notifications.dart';
import '../widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';

import 'surnameList.dart';

class TabsWidget extends StatefulWidget {

  @override
  State<TabsWidget> createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {
  MyProvider m=Get.find();

  StreamSubscription? internetconnection;

  bool isoffline = false;

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

  void _selectTab(int tabItem) {
    print(tabItem);
    m.selectedTab.value = tabItem;
      switch (tabItem) {
        case 0:
          m.currentTitle.value = 'All Contacts';
          m.currentTab.value = 3;

          break;
        case 1:
          m.currentTitle.value = 'City List';
          m.currentTab.value = 5;
          break;
        case 2:
          m.currentTitle.value = 'Surname List';
          m.currentTab.value = 2;
          break;
        case 3:
          m.currentTitle.value = 'Business List';
          m.currentTab.value = 4;
          break;

      }

  }

  @override
  Widget build(BuildContext context) {

    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
            _scaffoldKey.currentState?.openDrawer();
          });},
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Obx(() => Text(
          m.currentTitle.value,
          style: Theme.of(context).textTheme.displayLarge,
        )),

      ),
      body: !isoffline?Obx(() => m.currentPage[m.currentTab.value]):Center(child: Text("No Internet Connection")),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Color(0xff2D6064),
        // selectedFontSize: 0,
        // unselectedFontSize: 0,
        iconSize: 22,
        elevation: 0,
        // backgroundColor: Colors.transparent,
        selectedIconTheme: IconThemeData(size: 25),
        unselectedItemColor: Theme.of(context).hintColor.withOpacity(1),
        currentIndex: m.selectedTab.value,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        // selectedLabelStyle:TextStyle(color: Colors.black),
        onTap: (int i) {
          _selectTab(i);
        },
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            label: "કોન્ટેક્ટ",
            icon: new Icon(Icons.sort_by_alpha),
            // title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
              icon: Icon(UiIcons.map),
              label: "શહેરો"
            // title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
              label: "અટક",
              icon: Icon(Icons.list_alt)),
          BottomNavigationBarItem(
              icon: Icon(UiIcons.information),
              label: "બિઝનેસ"
            // title: new Container(height: 0.0),
          ),


          // BottomNavigationBarItem(
          //   label: "one",
          //   icon: new Icon(UiIcons.heart),
          //   // title: new Container(height: 0.0),
          // ),
          // BottomNavigationBarItem(
          //   label: "one",
          //   icon: new Icon(UiIcons.heart),
          //   // title: new Container(height: 0.0),
          // ),
        ],
      )),

    );
  }
}


//
// class TabsWidget extends StatefulWidget {
//
//   MyProvider m=Get.find();
//   Widget currentPage = HomeWidget();
//
//   TabsWidget({
//      Key? key,
//      required this.currentTab,
//   }) : super(key: key);
//
//   @override
//   _TabsWidgetState createState() {
//     return _TabsWidgetState();
//   }
// }
//
// class _TabsWidgetState extends State<TabsWidget> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   @override
//   initState() {
//     _selectTab(widget.currentTab);
//     super.initState();
//   }
//
//   @override
//   void didUpdateWidget(TabsWidget oldWidget) {
//     _selectTab(oldWidget.currentTab);
//     super.didUpdateWidget(oldWidget);
//   }
//
//   void _selectTab(int tabItem) {
//     setState(() {
//       widget.currentTab = tabItem;
//       widget.selectedTab = tabItem;
//       switch (tabItem) {
//         case 0:
//           widget.currentTitle = 'Notifications';
//           widget.currentPage = NotificationsWidget();
//           break;
//         case 1:
//           widget.currentTitle = 'Account';
//           widget.currentPage = AccountWidget();
//           break;
//         case 2:
//           widget.currentTitle = 'Home';
//           widget.currentPage = HomeWidget();
//           break;
//         case 3:
//           widget.currentTitle = 'Contacts';
//           widget.currentPage = MessagesWidget();
//           break;
//         case 4:
//           widget.currentTitle = 'Favorites';
//           widget.currentPage = FavoritesWidget();
//           break;
//         case 5:
//           widget.selectedTab = 3;
//           widget.currentTitle = 'Chat';
//           widget.currentPage = ChatWidget();
//           break;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: DrawerWidget(),
//       endDrawer: FilterWidget(),
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: new IconButton(
//           icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
//           onPressed: () => _scaffoldKey.currentState?.openDrawer(),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           widget.currentTitle,
//           style: Theme.of(context).textTheme.displayLarge,
//         ),
//         actions: <Widget>[
//           Container(
//               width: 30,
//               height: 30,
//               margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(300),
//                 onTap: () {
//                   Navigator.of(context).pushNamed('/Tabs', arguments: 1);
//                 },
//                 child: CircleAvatar(
//                   backgroundImage: AssetImage('img/user2.jpg'),
//                 ),
//               )),
//         ],
//       ),
//       body: widget.currentPage,
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Theme.of(context).accentColor,
//         selectedFontSize: 0,
//         unselectedFontSize: 0,
//         iconSize: 22,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         selectedIconTheme: IconThemeData(size: 25),
//         unselectedItemColor: Theme.of(context).hintColor.withOpacity(1),
//         currentIndex: widget.selectedTab,
//         onTap: (int i) {
//           this._selectTab(i);
//         },
//         // this will be set when a new tab is tapped
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(UiIcons.bell),
//             label: "one"
//             // title: new Container(height: 0.0),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(UiIcons.user_1),
//               label: "one"
//             // title: new Container(height: 0.0),
//           ),
//           BottomNavigationBarItem(
//               label: "one",
//               // title: new Container(height: 5.0),
//               icon: Container(
//                 width: 45,
//                 height: 45,
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).accentColor.withOpacity(0.8),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(50),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Theme.of(context).accentColor.withOpacity(0.4), blurRadius: 40, offset: Offset(0, 15)),
//                     BoxShadow(
//                         color: Theme.of(context).accentColor.withOpacity(0.4), blurRadius: 13, offset: Offset(0, 3))
//                   ],
//                 ),
//                 child: new Icon(UiIcons.home, color: Theme.of(context).primaryColor),
//               )),
//           BottomNavigationBarItem(
//           label: "one",
//             icon: new Icon(UiIcons.chat),
//             // title: new Container(height: 0.0),
//           ),
//           BottomNavigationBarItem(
//             label: "one",
//             icon: new Icon(UiIcons.heart),
//             // title: new Container(height: 0.0),
//           ),
//         ],
//       ),
//     );
//   }
// }
