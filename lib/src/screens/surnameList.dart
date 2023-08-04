import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingorala/src/models/SurnameList.dart';
import 'package:ingorala/src/screens/AllContacts.dart';
import 'package:ingorala/src/screens/surnamewiseContacts.dart';

import '../MyProvider.dart';

import 'dart:math' as math;

import '../widgets/EmptyMessagesWidget.dart';

class surname extends StatefulWidget {
  const surname({Key? key}) : super(key: key);

  @override
  State<surname> createState() => _surnameState();
}

class _surnameState extends State<surname> {
  MyProvider m = Get.put(MyProvider());
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('SurnameList').ref;
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
                      data, (key1, key2) => data[key1]!['eng_surname'].compareTo(data[key2]!['eng_surname']));
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
                        SurnameListResult surnamelist=SurnameListResult.fromJson(e.value);
                        return OpenContainer(
                          closedBuilder: (context, action) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: Theme.of(context).hintColor
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${surnamelist.gujSurname}",
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                    ),
                                    Text(
                                      "${surnamelist.engSurname}",
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          openBuilder: (context, action) {
                            return StatefulBuilder(builder: (context, setState) {
                              // return Container();
                              return SurnameWiseContacts(surnamelist.gujSurname);
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
        //             SurnameList surnameList=snapshot.data as SurnameList;
        //            return GridView.builder(
        //              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //                  crossAxisCount: 2
        //              ),
        //              padding: EdgeInsets.symmetric(vertical: 15),
        //              shrinkWrap: true,
        //              primary: false,
        //              itemCount:surnameList.result!.length,
        //              itemBuilder: (context, index) {
        //                return OpenContainer(
        //                  closedBuilder: (context, action) {
        //                    return Container(
        //                      margin: EdgeInsets.all(10),
        //                      decoration: BoxDecoration(
        //                          borderRadius: BorderRadius.circular(6),
        //                          border: Border.all(
        //                              color: Theme.of(context).hintColor
        //                          ),
        //                          boxShadow: [
        //                            BoxShadow(
        //                                color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
        //                          ]),
        //                      child: Column(
        //                        mainAxisAlignment: MainAxisAlignment.center,
        //                        children: [
        //                          Text(
        //                            "${surnameList.result![index].gujSurname}",
        //                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
        //                            maxLines: 1,
        //                            softWrap: false,
        //                            overflow: TextOverflow.fade,
        //                          ),
        //                          Text(
        //                            "${surnameList.result![index].engSurname}",
        //                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
        //                            maxLines: 1,
        //                            softWrap: false,
        //                            overflow: TextOverflow.fade,
        //                          ),
        //                        ],
        //                      ),
        //                    );
        //                  },
        //                  openBuilder: (context, action) {
        //                    // print(alpha[index]);
        //                    // m.searchcontactList.value=m.tempcontactList.where((element) =>
        //                    //     element.e_name.toString().toLowerCase().startsWith(alpha[index].toLowerCase())).toList();
        //                    // m.searchtempcontactList.value=m.searchcontactList.value;
        //                    // print(m.searchcontactList.value);
        //                    return StatefulBuilder(builder: (context, setState) {
        //                      return SurnameWiseContacts(surnameList.result![index].gujSurname!);
        //                      // return SingleList(surnameList.result![index].gujSurname!);
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
        //       future: m.getAllSurname(),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
