import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingorala/src/models/BusinessList.dart';
import 'package:ingorala/src/models/SurnameList.dart';
import 'package:ingorala/src/screens/businessWiseContacts.dart';
import 'package:ingorala/src/screens/AllContacts.dart';
import 'package:ingorala/src/screens/surnamewiseContacts.dart';
import 'package:ingorala/src/widgets/EmptyMessagesWidget.dart';

import '../MyProvider.dart';

import 'dart:math' as math;

class businessCategory extends StatefulWidget {
  const businessCategory({Key? key}) : super(key: key);

  @override
  State<businessCategory> createState() => _businessCategoryState();
}

class _businessCategoryState extends State<businessCategory> {
  MyProvider m = Get.put(MyProvider());
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('BusinessList').ref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    starCountRef.keepSynced(true);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: StreamBuilder<DatabaseEvent>(
              stream: starCountRef.onValue,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Color(0xff2D6064)),
                  );
                }

                if(snapshot.hasData)
                {
                  Map<dynamic,dynamic> data = snapshot.data!.snapshot.value as Map<dynamic,dynamic>;
                  data = SplayTreeMap.from(
                      data, (key1, key2) => data[key1]!['category'].compareTo(data[key2]!['category']));
                  print("firebase length=${data.length}");
                  return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shrinkWrap: true,
                      primary: false,
                      children: data.entries.map((e) {
                        print("${e.key}==>${e.value}");
                        BusinessListResult c=BusinessListResult.fromJson(e.value);
                        return OpenContainer(
                          closedBuilder: (context, action) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              child: Stack(
                                alignment: AlignmentDirectional.topCenter,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: Theme.of(context).hintColor
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                                        ]),
                                    child: Center(
                                      child:Text(
                                        "${c.category}",
                                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                        maxLines: 3,
                                        textAlign: TextAlign.center,
                                        // softWrap: false,
                                        // overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          openBuilder: (context, action) {
                            return StatefulBuilder(builder: (context, setState) {
                              // return Container();
                              return BusinessWiseContacts(c.category);
                            },);
                          },
                          transitionDuration: Duration(seconds: 1),
                        );
                      }).toList()
                  );
                }
                else
                {
                  return EmptyMessagesWidget();
                }
              },
            )
        ),
        // Expanded(
        //   child: SingleChildScrollView(
        //     padding: EdgeInsets.symmetric(vertical: 7),
        //     child: FutureBuilder(
        //       builder: (context, snapshot) {
        //         if (snapshot.connectionState == ConnectionState.done) {
        //           if (snapshot.hasData) {
        //             BusinessList  businessList=snapshot.data as BusinessList;
        //            return GridView.builder(
        //              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //                  crossAxisCount: 2
        //              ),
        //              padding: EdgeInsets.symmetric(vertical: 15),
        //              shrinkWrap: true,
        //              primary: false,
        //              itemCount:businessList.result!.length,
        //              itemBuilder: (context, index) {
        //                return OpenContainer(
        //                  closedBuilder: (context, action) {
        //                    return Container(
        //                      margin: EdgeInsets.all(20),
        //                      child: Stack(
        //                        alignment: AlignmentDirectional.topCenter,
        //                        children: <Widget>[
        //                          Container(
        //                            decoration: BoxDecoration(
        //                                borderRadius: BorderRadius.circular(6),
        //                                border: Border.all(
        //                                    color: Theme.of(context).hintColor
        //                                ),
        //                                boxShadow: [
        //                                  BoxShadow(
        //                                      color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
        //                                ]),
        //                            child: Center(
        //                              child:Text(
        //                                "${businessList.result![index].category}",
        //                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
        //                                maxLines: 3,
        //                                textAlign: TextAlign.center,
        //                                // softWrap: false,
        //                                // overflow: TextOverflow.fade,
        //                              ),
        //                            ),
        //                          )
        //                        ],
        //                      ),
        //                    );
        //                  },
        //                  openBuilder: (context, action) {
        //                    return StatefulBuilder(builder: (context, setState) {
        //                      return BusinessWiseContacts(businessList.result![index].category!);
        //                    },);
        //                  },
        //                  transitionDuration: Duration(seconds: 1),
        //                );
        //              },
        //            );
        //           } else {
        //             return Center(
        //               child: CircularProgressIndicator(),
        //             );
        //           }
        //         } else {
        //           return Center(
        //             child: CircularProgressIndicator(),
        //           );
        //         }
        //       },
        //       future: m.getBusiness(),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
